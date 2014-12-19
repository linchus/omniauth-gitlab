require 'faraday'
require 'multi_json'
require 'omniauth'

module OmniAuth
  module Strategies
    class GitLab
      include OmniAuth::Strategy

      option :fields, [:email]
      option :site, nil
      option :v, 'v3'
      option :uid_field, :email
      option :on_login, nil
      option :on_registration, nil
      option :on_failed_registration, nil

      def request_phase
        if options[:on_login]
          options[:on_login].call(self.env)
        else
          form = OmniAuth::Form.new(:title =>  (options[:title] || "Gitlab Verification"), :url => callback_path)

          form.text_field 'Username or e-mail', 'login'
          form.password_field 'Password', 'password'
          form.button "Sign In"
          form.to_response
        end
      end

      def callback_phase
        return fail!(:invalid_credentials) unless identity
        super
      end

      uid{ identity['id'].to_s }
      info do
        {
          :name => identity['name'],
          :email => identity['email'],
          :nickname => identity['username']
        }
      end

      credentials do
        { :token => identity['private_token'] }
      end

      extra do
        { :raw_info => identity }
      end

      def identity
        @identity ||= begin
          conn = Faraday.new(:url => options[:site])
          key = is_email?(request['login']) ? :email : :login
          resp = conn.post do |req|
            req.url "/api/#{options[:v]}/session"
            req.headers['Content-Type'] = 'application/json'
            req.params = {
              key  => request['login'],
              :password => request['password']
            }
          end
          resp.success? ? MultiJson.decode(resp.body) : nil
        end
      end

      # check if login string looks like email
      def is_email?(str)
        str.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]+\.)[a-zA-Z]{2,4}/)
      end
    end
  end
end


OmniAuth.config.add_camelization 'gitlab', 'GitLab'
