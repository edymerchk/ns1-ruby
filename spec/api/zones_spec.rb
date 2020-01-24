require "spec_helper"

RSpec.describe NS1::API::Zones do

  let(:client) { NS1::Client.new("sample-api-key") }

  describe '#zones' do
    it 'makes a request to GET /zones' do
      request = stub_ns1_api(:get, "zones")

      client.zones

      expect(request).to have_been_requested
    end
  end

  describe '#zone' do
    it 'makes a request to GET /zones/:zone' do
      request = stub_ns1_api(:get, "zones/sample.com")

      client.zone("sample.com")

      expect(request).to have_been_requested
    end
  end

  describe '#create_zone' do
    let(:expected_body) do
      {
        nx_ttl: 60,
        zone: "sample.com"
      }
    end

    it 'makes a request to PUT /zones/sample.com with the expected body' do
      request = stub_ns1_api(:put, "zones/sample.com", expected_body.to_json)

      client.create_zone("sample.com", {nx_ttl: 60})

      expect(request).to have_been_requested
    end
  end

  describe '#update_zone' do
    let(:expected_body) do
      {
        refresh: 50
      }
    end

    it 'makes a request to POST /zones/sample.com with the expected body' do
      request = stub_ns1_api(:post, "zones/sample.com", expected_body.to_json)

      client.update_zone("sample.com", {refresh: 50})

      expect(request).to have_been_requested
    end
  end

  describe '#delete_zone' do
    it 'makes a request to DELETE /zones/:zone' do
      request = stub_ns1_api(:delete, "zones/sample.com")

      client.delete_zone("sample.com")

      expect(request).to have_been_requested
    end
  end

  def stub_ns1_api(method, endpoint, body = nil)
    stub_request(method, "#{NS1::Client::API_ENDPOINT}/#{endpoint}")
      .with(body: body)
      .to_return(status: 200, body: nil)
  end
end
