lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "NS1/version"

Gem::Specification.new do |spec|
  spec.name          = "NS1"
  spec.version       = NS1::VERSION
  spec.authors       = ["Edy Laverde"]
  spec.email         = ["edyhack@gmail.com"]

  spec.summary       = %q{NS1 Ruby Client}
  spec.description   = %q{NS1 Ruby Client}
  spec.homepage      = "https://github.com/edymerchk"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "faraday", ["= 1.0.0"]
  spec.add_runtime_dependency "oj", ["= 3.10.1"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.8.0"
  spec.add_development_dependency "pry-byebug", "~> 3.7.0"
end
