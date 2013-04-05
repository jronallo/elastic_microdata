class Page

  include Tire::Model::Persistence

  property :url
  property :title
  property :description
  property :microdata, :type => :nested
  property :itemtypes, :type => :array
  property :itemprops, :type => :array

  def self.build(url, html)
    items = Microdata::Document.new(html, url).extract_items
    hash = {}
    hash[:items] = items.map do |item|
      item.to_hash
    end
    itemtypes = extract_itemtypes(items)
    Page.create :microdata => hash, :id => url, :itemtypes => itemtypes
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