
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class GitLab < OmniAuth::Strategies::OAuth2

      option :client_options, {
          site: 'https://gitlab.com',
          authorize_url: '/oauth/authorize',
          token_url: '/oauth/token'
      }

      uid { raw_info['id'].to_s }

      info do
        {
            name:     raw_info['name'],
            username: raw_info['username'],
            email:    raw_info['email']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v3/user').parsed
      end
    end
  end
end


OmniAuth.config.add_camelization 'gitlab', 'GitLab'
