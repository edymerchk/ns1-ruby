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
    context 'when the zone does not exists' do
      it 'raises the proper error' do
        stub_ns1_api(:get, "zones/sample.com", response_status: 404)

        expect {
          client.zone("sample.com")
        }.to raise_error NS1::Client::NotFoundError
      end
    end

    context 'when the zone exists' do
      it 'makes a request to GET /zones/:zone' do
        request = stub_ns1_api(:get, "zones/sample.com")

        client.zone("sample.com")

        expect(request).to have_been_requested
      end
    end
  end

  describe '#create_zone' do
    context 'when an ivalid domain name is used' do
      let(:expected_body) do
        {
          zone: "wrong"
        }
      end

      it 'raises the proper error' do
        stub_ns1_api(:put, "zones/wrong", body: expected_body.to_json, response_status: 400)

        expect {
          client.create_zone("wrong")
        }.to raise_error NS1::Client::BadRequestError
      end
    end

    context 'when a valid domain name is used' do
      let(:expected_body) do
        {
          nx_ttl: 60,
          zone: "sample.com"
        }
      end

      it 'makes a request to PUT /zones/:zone with the expected body' do
        request = stub_ns1_api(:put, "zones/sample.com", body: expected_body.to_json)

        client.create_zone("sample.com", {nx_ttl: 60})

        expect(request).to have_been_requested
      end
    end
  end

  describe '#update_zone' do
    let(:expected_body) do
      {
        refresh: 50
      }
    end

    it 'makes a request to POST /zones/:zone with the expected body' do
      request = stub_ns1_api(:post, "zones/sample.com", body: expected_body.to_json)

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
end
