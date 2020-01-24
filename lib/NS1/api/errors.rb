module NS1
  module API
    module Errors
      NS1APIError = Class.new(StandardError)
      BadRequestError = Class.new(NS1APIError)
      UnauthorizedError = Class.new(NS1APIError)
      NotFoundError = Class.new(NS1APIError)
      ResponseParseError = Class.new(NS1APIError)
      ApiError = Class.new(NS1APIError)
    end
  end
end