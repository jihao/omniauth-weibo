# OmniAuth weibo

This is the unofficial OmniAuth strategy for authenticating to weibo.com. To use it, you'll need to sign up for an OAuth2 App Key and App Secret on the [Sina weibo developer website](http://open.weibo.com/).

## Basic Usage

    use OmniAuth::Builder do
      provider :weibo, ENV['App_Key'], ENV['App_Secret']
    end