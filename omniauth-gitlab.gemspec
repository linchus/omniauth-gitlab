# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-gitlab/version'

Gem::Specification.new do |gem|
  gem.name          = "omniauth-gitlab"
  gem.version       = Omniauth::Gitlab::VERSION
  gem.authors       = ["ssein"]
  gem.email         = ["ssein@undev.ru"]
  gem.description   = %q{This is the strategy for authenticating to your GitLab service}
  gem.summary       = %q{This is the strategy for authenticating to your GitLab service}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency "faraday", "~> 0.9.0"
  gem.add_dependency 'multi_json', '~> 1.0'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
