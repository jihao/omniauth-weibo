require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Weibo < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "weibo"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
              :site => "https://api.weibo.com",
              :authorize_url => 'https://api.weibo.com/oauth2/authorize',
              :token_url => 'https://api.weibo.com/oauth2/access_token'
      }
      
      option :token_params, {
        # SET :parse because weibo oauth2 access_token response with "content-type"=>"text/plain;charset=UTF-8", 
        # and when you use ruby 1.8.7, the response body was not a valid HASH (see: https://github.com/intridea/oauth2/issues/75)
        # :body=>"{\"access_token\":\"2.001FOK5CacB2wCc20a59773d0uSGnj\",\"expires_in\":86400,\"uid\":\"2189335154\"}"}
        :parse => :json, 
      }
      
      def request_phase
        super
      end
      
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
        # SET :mode because by default it will use :header option, and send out header like
        # opts[:headers]={"Authorization"=>"Bearer 2.001FOK5CacB2wCc20a59773d0uSGnj"}
        # this doesn't align with weibo API (see: http://open.weibo.com/wiki/2/account/get_uid)
        access_token.options[:mode] = :query
        access_token.options[:param_name] = 'access_token'
        @raw_info ||= access_token.get('/2/account/get_uid.json').parsed
        # maybe consider another call towards /account/profile/basic since /account/get_uid call only returns uid
      end
    end
  end
end

OmniAuth.config.add_camelization 'weibo', 'Weibo'
