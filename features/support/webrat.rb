require 'webrat'
require 'webrat/core/matchers'

Webrat.configure do |config|
  config.mode = :rack
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end
World Webrat::Methods
World Webrat::Matchers

module Webrat
  class Session
    def current_host
#      p "current_host current_url = #{URI.parse(current_url).host}, @custom_headers[\"Host\"] = #{@custom_headers["Host"]}"
      URI.parse(current_url).host || @custom_headers["Host"] || default_current_host
    end

    def default_current_host
      adapter.class==Webrat::RackAdapter ? "example.org" : "www.example.org"
    end
  end
end