require "spec_helper"

RSpec.describe NS1::Client do

  let(:client) { NS1::Client.new("sample-api-key") }

  describe '#request' do
    context 'when an good response is returned from the ns1 API' do
      let(:expected_body) do
       {
         "hola" => "mundo"
        }
      end

      it 'returns the expected body parsed' do
        request = stub_ns1_api(:get, "hello", response_body: expected_body.to_json, response_status: 200)

        response = client.request(:get, "hello")

        expect(response).to eq(expected_body)
      end
    end

    context 'when an malformed response is returned from the ns1 API' do
      it 'raises the proper error' do
        request = stub_ns1_api(:get, "hello", response_body: "no-json", response_status: 200)

        expect {
          client.request(:get, "hello")
        }.to raise_error NS1::Client::ResponseParseError
      end
    end


    context 'when an invalid api-key is used' do
      it 'raises the proper error' do
        request = stub_ns1_api(:get, "hello", response_status: 401)

        expect {
          client.request(:get, "hello")
        }.to raise_error NS1::Client::UnauthorizedError
      end
    end

    context 'when an unknown error is returned from the ns1 API' do
      it 'raises the proper error' do
        request = stub_ns1_api(:get, "hello", response_status: 500)

        expect {
          client.request(:get, "hello")
        }.to raise_error NS1::Client::ApiError
      end
    end
  end
end
