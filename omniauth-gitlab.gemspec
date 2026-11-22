# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-gitlab/version'

Gem::Specification.new do |gem|
  gem.name          = 'omniauth-gitlab'
  gem.version       = Omniauth::Gitlab::VERSION
  gem.authors       = ['Sergey Sein']
  gem.email         = ['linchus@gmail.com']
  gem.description   = 'This is the strategy for authenticating to your GitLab service'
  gem.summary       = 'This is the strategy for authenticating to your GitLab service'
  gem.homepage      = 'https://github.com/linchus/omniauth-gitlab'

  gem.files         = Dir['lib/**/*.rb'] + %w[LICENSE.txt README.md]
  gem.require_paths = ['lib']
  gem.required_ruby_version = '>= 2.5'

  gem.add_dependency 'omniauth', '~> 2.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.9'
  gem.add_development_dependency 'rspec', '~> 3.13'
  gem.add_development_dependency 'rspec-its', '~> 1.0'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'rake', '>= 12.0'
end
