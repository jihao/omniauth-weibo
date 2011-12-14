# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-weibo/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-weibo"
  s.version     = Omniauth::Weibo::VERSION
  s.authors     = ["Hao Ji"]
  s.email       = ["jacky.jihao@gmail.com"]
  s.homepage    = "https://github.com/jihao/omniauth-weibo"
  s.summary     = %q{omniauth strategy for weibo.com (t.sina.com.cn) }
  s.description = %q{omniauth strategy for weibo.com (t.sina.com.cn), Authenticate to weibo.com using its OAuth 2.0 API.}

  s.rubyforge_project = "omniauth-weibo"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'omniauth', '~> 1.0'
  s.add_dependency 'omniauth-oauth2', '~> 1.0'
  s.add_development_dependency 'rspec', '~> 2.7'
  # s.add_runtime_dependency "rest-client"
end
