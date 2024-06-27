require 'elasticsearch/model'

Elasticsearch::Model.client = Elasticsearch::Client.new(
  url: ENV['ELASTICSEARCH_URL'] || 'http://elasticsearch:9200',
  log: true,
  transport_options: {
    request: { timeout: 5 }
  }
)
