# NS1

[NS1](https://ns1.com/) Ruby Client


## Installation

Add this line to your application's Gemfile:

```ruby
gem "ns1-ruby", '~> 0.1.0', require: 'NS1'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ns1-ruby

## Usage

```ruby
# Initialize client
# Get your api-key from https://my.nsone.net/#/account/settings
ns1_client = NS1::Client.new("api-key")
```

### Zones

```ruby
# Get all the zones
ns1_client.zones

# Get an zone
ns1_client.zone("sample.dev")

# Create zone
# see full list of params on https://ns1.com/api#create-a-new-dns-zone
params = {nx_ttl: 3600, ...}
ns1_client.create_zone("sample.dev", params)

# Update zone
# see full list of params on https://ns1.com/api#post-modify-a-zone
params = {refresh: 1200, ...}
ns1_client.update_zone("sample.dev", params)

# Delete zone
ns1_client.delete_zone("sample.dev")
```

### Records
```ruby
# Get a record
ns1_client.record("sample.dev", "www.sample.dev", "A")

# Create record
# see full list of params on https://ns1.com/api#putcreate-a-new-dns-record
params = {answers: ["1,1,1,1"], ...}
ns1_client.create_record("sample.dev", "www.sample.dev", "A", params)


# Update record
# see full list of params on https://ns1.com/api#postupdate-record-configuration
params = {use_client_subnet: false, ...}
ns1_client.update_record("sample.dev", "www.sample.dev", "A", params)

# Delete record
ns1_client.delete_record("sample.dev", "www.sample.dev", "A")

```

### Exceptions

If an error occurs during an operation, one of the following exceptions will be raised, otherwise the operation will be considered successful and the response body will be returned

```ruby
NS1::API::Errors::BadRequestError
NS1::API::Errors::UnauthorizedError
NS1::API::Errors::NotFoundError
NS1::API::Errors::ResponseParseError
NS1::API::Errors::ApiError
```

### Future Work

* Cover all the resources on the NS1 Api https://ns1.com/api
* I think it will be interesting to create ruby objects for each entity, that way we can do something like: `ns1_client.zone("sample.dev").nx_ttl` and even `ns1_client.zone("sample.dev").records`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/NS1. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NS1 project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/NS1/blob/master/CODE_OF_CONDUCT.md).
