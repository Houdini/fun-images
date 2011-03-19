module Rack
  # Sets an "X-Runtime" response header, indicating the response
  # time of the request, in seconds
  #
  # You can put it right before the application to see the processing
  # time, or before all the other middlewares to include time for them,
  # too.
  class Runtime
    def initialize(app, name = nil)
      @app = app
    end

    def call(env)
      start_time = Time.now
      status, headers, response = @app.call(env)

      if headers.include? "Content-Type" and headers["Content-Type"].include? 'text/html' and response.respond_to? :body and response.body.class == String
        request_time = Time.now - start_time
        response.body = "<!-- Response Time: #{request_time} -->\n" + response.body
      end
      [status, headers, response]
    end
  end
end
