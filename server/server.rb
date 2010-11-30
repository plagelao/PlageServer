require 'URI'

class Server
  METHODS = [ :GET ]

  def responseTo(request)
    @words = request.split
    do_method(request)
  end

  def do_method(request)
    return eval("do_#{first_word.downcase}") if METHODS.include?(first_word.upcase.to_sym) &&
                                                second_word_is_a_http_url &&
                                                ends_with_crlf(request) &&
                                                request[0...-2].end_with?("HTTP/1.1\r\n")
    400
  end

  def do_get()
    "Hello world"
  end

  def first_word
    @words.at(0)
  end

  def second_word_is_a_http_url
    URI.parse(@words.at(1)).is_a?URI::HTTP
  end

  def ends_with_crlf(request)
    request.end_with?"\r\n"
  end

end
