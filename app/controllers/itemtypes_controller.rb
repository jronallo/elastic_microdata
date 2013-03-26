class ItemtypesController < ApplicationController
  def index
    response = ESCLIENT.search(
      :query => {
        :match_all => { },
        
      }, :facets => {:type => {:terms =>  {:field => :type}}}
    )
    @itemtypes = response.facets['type']['terms']
  end

  def show
    page = params["page"] || 1
    @page = page.to_i
    from = @page.to_i * 25
    response = ESCLIENT.search(
      :query => {
        :term => {
          :type => params['id']
        }      
      },
        :size => 25,
        :from => from  
      
    )
    @hits = response.hits
  end
end


