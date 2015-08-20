require "rubygems"

# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "docks_theme_base/version"

Gem::Specification.new do |s|
  s.name                  = "docks_theme_base"
  s.version               = Docks::Themes::Base::VERSION
  s.platform              = Gem::Platform::RUBY
  s.required_ruby_version = ">= 1.9.3"
  s.authors               = ["Chris Sauve"]
  s.email                 = ["chrismsauve@gmail.com"]
  s.license               = "MIT"
  s.homepage              = "http://github.com/docks-app/docks_theme_base"
  s.summary               = "An base theme for Docks."
  s.description           = s.summary

  s.files                 = `git ls-files`.split("\n")
  s.test_files            = `git ls-files -- spec/*`.split("\n")
  s.executables           = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths         = ["lib"]

  s.add_dependency "activesupport"
  s.add_dependency "docks", github: "docks-app/docks"

  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rubocop", "< 1.0"
  s.add_development_dependency "rake", "~> 10.4"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "awesome_print", "~> 1.6"
  s.add_development_dependency "rspec-html-matchers", "~> 0.7"
  s.add_development_dependency "html2haml", "~> 2.0"
  s.add_development_dependency "html2slim", "~> 0.2"
end
