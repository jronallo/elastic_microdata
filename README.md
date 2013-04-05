# elastic_microdata

A Rails app which:

1. crawls sitemaps
2. extracts microdata
3. indexes the microdata in elasticsearch
4. allows you to find pages with a particular type of item

# Getting Started

You'll need a recent version of Ruby (probably 1.9.3 or 2.0.0--no suppot for 1.8.7).

1. Clone the project and run `bundle`

2. Install elasticsearch and start it

```
$ curl -k -L -o elasticsearch-0.20.2.tar.gz http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.20.2.tar.gz
$ tar -zxvf elasticsearch-0.20.2.tar.gz
$ mv elasticsearch-0.20.2 elasticsearch
$ ./elasticsearch/bin/elasticsearch -f
```

2. Index a sitemap

```
$ bundle exec rake elastic_microdata:sitemap:index[http://d.lib.ncsu.edu/collections/sal-sitemap.xml]
```

While this is happening you can go to a new terminal and take a look at what's coming in.

3. Start the server

`bundle exec rails server`

4. Visit http://localhost:3000

5. See what Microdata types have been extracted
