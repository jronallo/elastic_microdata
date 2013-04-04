# elastic_microdata

A Rails app which:

1. crawls sitemaps
2. extracts microdata
3. indexes the microdata in elasticsearch
4. allows searching and faceting of pages and items

(OK, it doesn't do all that yet, but that's the goal.)

# Getting Started

1. Install elasticsearch and start it

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