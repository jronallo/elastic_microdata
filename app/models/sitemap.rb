class Sitemap
  include Tire::Model::Persistence

  property :url, :index => :not_analyzed, :type => :string
  
  def crawl
    sitemap_xml = open(url).read
    if sitemap_xml.include?('sitemapindex')
      Nokogiri::HTML(sitemap_xml).xpath('//loc').each do |sitemap_loc|
        sitemap_xml = open(sitemap_loc.text).read
        index_sitemap(sitemap_xml)
      end
    else
      index_sitemap(sitemap_xml)
    end
  end

  private

  def index_sitemap(sitemap_xml)
    begin
      sitemap = Zlib::GzipReader.new( StringIO.new(sitemap_xml) ).read
    rescue => e
      sitemap = sitemap_xml
    end
    Nokogiri::HTML(sitemap).xpath('//loc').each_with_index do |loc, index|
      url = loc.content
      tries = 0
      begin
        if tries < 10
          sleep tries 
          open(url) do |f|
            Page.build(@url, url, f) 
          end
        end
      rescue => e 
        puts e
        puts e.backtrace
        puts "Error with: #{url}"
        tries += 1
        retry
      end
      puts url
    end
  end

end

Sitemap.create_elasticsearch_index