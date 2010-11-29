class RequestLine
 
  def initialize(request_line)
    @request_line = request_line
  end

  def well_formed?
    tokens = @request_line.split
    if (tokens.at(0) != 'GET')
      return false
    end
    tokens.at(1).start_with?("http://")
  end
end
