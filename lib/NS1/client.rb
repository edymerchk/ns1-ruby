require 'NS1/api/zones'
require 'NS1/api/records'
require 'NS1/api/http_status_codes'
require 'NS1/api/errors'
require 'faraday'
require 'oj'
require 'json'

module NS1
  class Client
    include NS1::API::Zones
    include NS1::API::Records

    include NS1::API::HttpStatusCodes
    include NS1::API::Errors

    API_ENDPOINT = 'https://api.nsone.net/v1'.freeze

    def initialize(api_key)
      @api_key = api_key
    end

    def request(http_method, endpoint, params = nil)
      response = client.public_send(http_method, endpoint, params)
      parsed_response = Oj.load(response.body)

      return parsed_response if response.status == HTTP_OK_CODE

      raise error_class(response.status), Oj.load(response.body)["message"]

    rescue Oj::ParseError
      raise ResponseParseError, response.body
    end

    private

    def error_class(status)
      case status
      when HTTP_BAD_REQUEST_CODE
        BadRequestError
      when HTTP_UNAUTHORIZED_CODE
        UnauthorizedError
      when HTTP_NOT_FOUND_CODE
        NotFoundError
      else
        ApiError
      end
    end

    def client
      @client ||= Faraday.new(API_ENDPOINT) do |client|
        client.headers['X-NSONE-Key'] = @api_key
      end
    end
  end
end