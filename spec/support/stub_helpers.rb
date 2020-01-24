module StubHelpers
  def stub_ns1_api(method, endpoint, body: nil, response_status: 200)
    stub_request(method, "#{NS1::Client::API_ENDPOINT}/#{endpoint}")
      .with(body: body)
      .to_return(status: response_status, body: nil)
  end
end