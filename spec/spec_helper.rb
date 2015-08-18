require "docks_theme_base"
require "fileutils"
require "ostruct"
require "awesome_print"
require "rspec-html-matchers"

RSpec.configure do |config|
  config.include RSpecHtmlMatchers

  config.order = "random"

  config.mock_with :rspec do |c|
    c.syntax = :expect
  end
end
