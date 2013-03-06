require 'spec_helper'

describe OmniAuth::Strategies::GitLab do
  attr_accessor :app
  
  let(:auth_hash){ last_response.headers['env']['omniauth.auth'] }
  
  def set_app!(gitlab_options = {})
    old_app = self.app
    self.app = Rack::Builder.app do
      use Rack::Session::Cookie
      use OmniAuth::Strategies::GitLab, {:site => 'http://some.site.com/'  }.merge(gitlab_options)
      run lambda{|env| [404, {'env' => env}, ["HELLO!"]]}
    end
    if block_given?
      yield
      self.app = old_app
    end
    self.app
  end

  before(:all) do
    set_app!
  end

  describe '#request_phase' do
    it 'should display a form' do
      get '/auth/gitlab'
      last_response.body.should be_include("<form")
    end
  end

  describe '#callback_phase' do
    
    context 'with valid credentials' do
      before do
       stub_request(:post, "http://some.site.com/api/v3/session?email=john@test.com&password=awesome").
         with(:headers => {'Content-Type'=>'application/json'}).
         to_return(:status => 200, :body => '{
                                "id": 1,
                                "username": "john_smith",
                                "email": "john@example.com",
                                "name": "John Smith",
                                "private_token": "dd34asd13as",
                                "created_at": "2012-05-23T08:00:58Z",
                                "blocked": true
                            }')
        post '/auth/gitlab/callback', :email => 'john@test.com', :password => 'awesome'
      end
      
      it 'should populate the auth hash' do
        auth_hash.should be_kind_of(Hash)
      end

      it 'should populate the uid' do
        auth_hash['uid'].should eq '1'
      end

      it 'should populate the info hash' do
        auth_hash.info.name.should eq 'John Smith'
        auth_hash.info.email.should eq 'john@example.com'
        auth_hash.info.nickname.should eq 'john_smith' 
      end
            
    end
    
    context 'with invalid credentials' do
      before do
       stub_request(:post, "http://some.site.com/api/v3/session?email=john@test.com&password=incorrect").
         with(:headers => {'Content-Type'=>'application/json'}).
         to_return(:status => 401, :body => '{"message":"401Unauthorized"}')
        post '/auth/gitlab/callback', :email => 'john@test.com', :password => 'incorrect'
      end

      it 'should fail with :invalid_credentials' do
        last_response.should be_redirect
        last_response.headers['Location'].should eq "/auth/failure?message=invalid_credentials&strategy=gitlab"
      end      

    end
  end
  
end