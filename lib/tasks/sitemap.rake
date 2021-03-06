namespace :elastic_microdata do
  namespace :sitemap do

    desc "Index a sitemap into elasticsearch"
    task :index, [:sitemap_url]  => :environment  do |t, args|
      Sitemap
      sitemap = Sitemap.search do
        query do
          string %Q|url:"#{args.sitemap_url}"|
        end
      end.first
      if !sitemap
        puts 'Creating sitemap.'
        sitemap = Sitemap.create(:url => args.sitemap_url)
      else
        puts 'Retrieved sitemap.'
      end
      puts 'Crawling sitemap...'
      sitemap.crawl
    end

  end
end