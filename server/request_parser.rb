require 'URI'

class RequestParser

  def parse(request)
    @request_parts = request.split "\r\n"
    request_line = @request_parts.at(0)
    @words = request_line.split
    yield("/") if first_word_is_a_get &&
                  second_word_is_a_http_url &&
                  ends_with_crlf(request) &&
                  request_line_ends_with_http11
  end

  def first_word_is_a_get
    @words.at(0) == 'GET'
  end

  def second_word_is_a_http_url
     (@words.at(1) == "/") || URI.parse(@words.at(1)).is_a?(URI::HTTP)
  end

  def ends_with_crlf(request)
    request.end_with?"\r\n\r\n"
  end

  def request_line_ends_with_http11()
    @words.at(2) == "HTTP/1.1"
  end


end
