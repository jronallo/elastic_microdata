class ItemtypesController < ApplicationController
  def index
    search = Tire.search(
      'pages',
      :query => {
        :match_all => { },        
      }, 
      :facets => {
        :type => {
          :terms =>  {
            "field" => "itemtypes",
            "size" => 25
          }
        }
      }
    )
    @itemtypes = search.results.facets['type']['terms']
  end

  def show
    page = params["page"] || 1
    @page = page.to_i
    from = (@page.to_i - 1) * 25
    query_string = %Q|http://schema.org/#{params[:id]}|
    search = Tire.search(
      :pages,
      :query => {
        :term => {
          :itemtypes => query_string
        },        
      },
      :size => 25,
      :from => from      
    )
    # TODO: here's an alternate query that seemed to work
    # search = Tire.search(
    #   :pages,
    #   :query => {
    #     :match_all => { },        
    #   },
    #   :filter => {
    #     "and" => [
    #       { "terms" => {"itemtypes" => [query_string]} }
    #     ]
    #   },
    #   :size => 25,
    #   :from => from      
    # )
    @results = search.results
  end
end


