class ItemtypesController < ApplicationController
  def index
    response = ESCLIENT.search(
      :query => {
        :match_all => { },
        
      }, :facets => {
        :type => {
          :terms =>  {
            "script_field" => "_source.type",
            "size" => 10
          }
        }
      }
    )
    @itemtypes = response.facets['type']['terms']
  end

  def show
    page = params["page"] || 1
    @page = page.to_i
    from = @page.to_i * 25
    response = ESCLIENT.search(
      :query => {
        "bool" => {"must" => [{"query_string" => {"default_field" => "resource.type","query" => params['id']}}]}     
      },
      :size => 25,
      :from => from, 
      :facets => {
        :name => {
          :terms =>  {
            "script_field" => "_source.properties['name']",
            "size" => 100
          }
        }
      }       
    )
    @hits = response.hits
    @names = response.facets['name']['terms']
  end
end


