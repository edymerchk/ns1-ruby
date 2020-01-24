require 'NS1/api/zones'
require 'faraday'
require 'oj'

module NS1
  class Client
    include NS1::API::Zones

    API_ENDPOINT = "https://api.nsone.net/v1"

    def initialize(api_key)
      @api_key = api_key
    end

    def request(http_method, endpoint, params = nil)
      response = client.public_send(http_method, endpoint, params)
      Oj.load(response.body)
    end

    def client
      @client ||= Faraday.new(API_ENDPOINT) do |client|
        client.headers['X-NSONE-Key'] = @api_key
      end
    end
  end
end