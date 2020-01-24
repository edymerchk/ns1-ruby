module StubHelpers
  def stub_ns1_api(method, endpoint, body = nil)
    stub_request(method, "#{NS1::Client::API_ENDPOINT}/#{endpoint}")
      .with(body: body)
      .to_return(status: 200, body: nil)
  end
end