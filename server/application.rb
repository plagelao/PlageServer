class ApplicationFactory

  APPLICATIONS = {:tutorial => "<html><head></head>\n<body>\n<h3>\nWelcome to the tutorial\n</h3>\n<p>To add a web page put it in the same directory where the server is running</p></body></html>"}

  def create(application_name)
    return RootApplication.new if application_name == '/'
    app = (application_name.slice(1..-1).to_sym)
    return UserApplication.new(application_name, APPLICATIONS[app]) if APPLICATIONS.include?(app)
    NotFoundApplication.new application_name
  end

end

class RootApplication
  def response
     "HTTP/1.1 200 OK\r\n\r\n<html><head></head>\n<body>\n<h3>\nWelcome to PlageServer. Visit /tutorial for more information\n</h3>\n</body></html>"
  end
  def uri
    '/'
  end
end

class UserApplication
  def initialize(uri, html)
    @uri = uri
    @html = html
  end
  def response
    "HTTP/1.1 200 OK\r\n\r\n#{@html}"
  end
  def uri
    @uri
  end
end

class NotFoundApplication
  def initialize(uri)
    @uri = uri
  end
  def response
    "HTTP/1.1 404 Not Found\r\n\r\n"
  end
  def uri
    @uri
  end
end
