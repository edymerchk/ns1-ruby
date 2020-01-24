require "spec_helper"

RSpec.describe NS1::API::Zones do

  let(:client) { NS1::Client.new("sample-api-key") }

  describe '#record' do
    it 'makes a request to GET /zones/:zone/:domain/:type' do
      request = stub_ns1_api(:get, "zones/sample.com/www.sample.com/A")

      client.record("sample.com", "www.sample.com", "A")

      expect(request).to have_been_requested
    end
  end

  describe '#create_record' do
    let(:expected_body) do
      {
        answers: [{answer: ["1.1.1.1"]}],
        zone: "sample.com",
        domain: "www.sample.com",
        type: "A"
      }
    end

    it 'makes a request to PUT /zones/:zone/:domain/:type with the expected body' do
      request = stub_ns1_api(:put, "zones/sample.com/www.sample.com/A", expected_body.to_json)

      client.create_record("sample.com", "www.sample.com", "A", {answers: [{answer: ["1.1.1.1"]}]})

      expect(request).to have_been_requested
    end
  end

  describe '#update_record' do
    let(:expected_body) do
      {
        answers: [{answer: ["2.2.2.2"]}]
      }
    end

    it 'makes a request to POST /zones/:zone/:domain/:type with the expected body' do
      request = stub_ns1_api(:post, "zones/sample.com/www.sample.com/A", expected_body.to_json)

      client.update_record("sample.com", "www.sample.com", "A", {answers: [{answer: ["2.2.2.2"]}]})

      expect(request).to have_been_requested
    end
  end

  describe '#delete_record' do
    it 'makes a request to DELETE /zones/:zone/:domain/:type' do
      request = stub_ns1_api(:delete, "zones/sample.com/www.sample.com/A")

      client.delete_record("sample.com", "www.sample.com", "A")

      expect(request).to have_been_requested
    end
  end
end
