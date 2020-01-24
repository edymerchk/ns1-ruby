module StubHelpers
  def stub_ns1_api(method, endpoint, body: nil, response_status: 200, response_body: nil)
    stub_request(method, "#{NS1::Client::API_ENDPOINT}/#{endpoint}")
      .with(body: body)
      .to_return(status: response_status, body: response_body)
  end
end