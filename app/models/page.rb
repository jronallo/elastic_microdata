class Page

  include Tire::Model::Persistence  

  property :url, :type => :string, :index => :not_analyzed
  property :sitemap, :type => :string, :index => :not_analyzed
  property :lastmod, :type => :date
  property :title, :type => :string
  property :description, :type => :string
  property :microdata, :type => :object
  property :itemtypes, :type => :string, :index => :not_analyzed
  property :itemprops, :type => :string, :index => :not_analyzed

  def self.build(sitemap_url, url, html)
    items = Microdata::Document.new(html, url).extract_items
    hash = {}
    hash[:items] = items.map do |item|
      item.to_hash
    end
    itemtypes = extract_itemtypes(items)
    Page.create :sitemap => sitemap_url, 
                :microdata => hash, 
                :id => url, :itemtypes => itemtypes
  end

  private

  def self.extract_itemtypes(items)
    items.map do |item|      
      item.properties.each do |property, values|
        item_values = values.select do |value|
          value.is_a?(Microdata::Item) ? true : false
        end  
        extract_itemtypes(item_values)                 
      end
      item.type
    end.flatten.compact
  end

end

Page.tire.create_elasticsearch_index