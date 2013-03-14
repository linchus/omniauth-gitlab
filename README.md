# Omniauth::Gitlab

This is the strategy for authenticating to your GitLab service. To
use it, you'll need to set gitlab url.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-gitlab'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-gitlab

## Basic Usage

    use OmniAuth::Builder do
      provider :gitlab, :site => 'https://your.git.lab.com/', :v => 'v3'
    end

Default value for :v parameter is 'v3'.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
