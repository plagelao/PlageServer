require 'URI'

class RequestParser

  CRLF = "\r\n"

  def initialize(options = {:request_line_parser => RequestLineParser.new})
    @parser = options[:request_line_parser]
  end

  def parse(request_string)
    @parser.parse(request_line_from request_string) do |application|
      yield application
    end if ends_with_crlf?(request_string)
  end

  def request_line_from(request_string)
    request_string.split(CRLF).at(0)
  end

  def ends_with_crlf?(request_string)
    request_string.end_with?(CRLF*2)
  end

end

class RequestLineParser
  METHODS = ['GET']
  HTTP_1_1 = "HTTP/1.1"

  def initialize(options = {:application_parser => ApplicationParser.new})
    @application_parser = options[:application_parser]
  end

  def parse(request_line)
    @words = request_line.split
    yield application if first_word_is_a_method &&
                         second_word_is_a_http_url &&
                         request_line_ends_with_http11
  end

  def first_word_is_a_method
    METHODS.include?@words.at(0)
  end

  def second_word_is_a_http_url
     (@words.at(1).start_with?("/")) || URI.parse(@words.at(1)).is_a?(URI::HTTP)
  end

  def request_line_ends_with_http11()
    @words.at(2) == HTTP_1_1
  end

  def application
    uri = @words.at 1
    @application_parser.parse uri
  end

end

class ApplicationParser

  def parse uri
    return uri unless absolute_uri?(uri)
    extract_application uri
  end

  def absolute_uri? uri
    uri.split('/').at(0) == 'http:'
  end

  def extract_application absolute_uri
    absolute_uri.slice(application_index(absolute_uri)..-1)
  end

  def application_index absolute_uri
    absolute_uri.index('/', 'http://'.length)
  end

end
