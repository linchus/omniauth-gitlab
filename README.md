# Omniauth::Gitlab

This is the OAuth2 strategy for authenticating to your GitLab service.

## Requirements

Gitlab 7.7.0+
 
## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-gitlab'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-gitlab

## Basic Usage

    use OmniAuth::Builder do
      provider :gitlab, ENV['GITLAB_KEY'], ENV['GITLAB_SECRET']
    end

## Standalone Usage

    use OmniAuth::Builder do
      provider :gitlab, ENV['GITLAB_KEY'], ENV['GITLAB_SECRET'], 
                                client_options: {
                                     site: enterprise_site,
                                     authorize_url: enterprise_authorize_url,
                                     token_url: enterprise_token_url
                                 }      
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
