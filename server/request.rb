require 'server/request_parser'

class Request

  def initialize(options)
    @request_string = options[:request]
    @parse = options[:parse]
    @applications = {:tutorial => "<html><head></head>\n<body>\n<h3>\nWelcome to the tutorial\n</h3>\n<p>To add a web page you must do a POST to the url that you want for that page and add the html of the page in the body of the POST request</p></body></html>"}
  end

  def response
    @parse.parse @request_string do |application|
      return create_response application
    end
    bad_request
  end

  def create_response(application)
    return "HTTP/1.1 200 OK\r\n\r\n#{@applications[application.slice(1..-1).to_sym()]}" if @applications.include?(application.slice(1..-1).to_sym)
    "HTTP/1.1 200 OK\r\n\r\n<html><head></head>\n<body>\n<h3>\nWelcome to PlageServer. Visit the <a href=\"./tutorial\">tutorial</a> for more information\n</h3>\n</body></html>"
  end

  def bad_request()
    "HTTP/1.1 400 Bad Request\r\n\r\n"
  end
end
