class Sitemap
  include Tire::Model::Persistence
  
  self.create_elasticsearch_index

  property :url, :index => :not_analyzed, :type => :string
  property :pages, :class => [Page]


  def index
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
    sitemap = Zlib::GzipReader.new( StringIO.new(sitemap_xml) ).read
    Nokogiri::HTML(sitemap).xpath('//loc').each_with_index do |loc, index|
      url = loc.content
      open(url) do |f|
        Page.build(url, f) 
      end
      puts url
    end
  end

end