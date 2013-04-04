class Page

  include Tire::Model::Persistence

  property :url
  property :title
  property :description
  property :microdata, :type => :nested
  property :itemtypes
  property :itemprops

end