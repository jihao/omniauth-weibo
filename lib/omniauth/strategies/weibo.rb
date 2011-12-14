require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Weibo < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "weibo"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {:site => "https://api.weibo.com",
              :authorize_url => 'https://api.weibo.com/oauth2/authorize',
              :token_url => 'https://api.weibo.com/oauth2/access_token'}

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['uid'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/account/get_uid').parsed
        # maybe consider another call towards /account/profile/basic since /account/get_uid call only returns uid
      end
    end
  end
end