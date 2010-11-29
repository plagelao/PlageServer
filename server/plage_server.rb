class RequestLine
 
  def initialize(request_line)
    @request_line = request_line
  end

  def well_formed?
    @request_line.split.at(0) == 'GET'
  end
end
