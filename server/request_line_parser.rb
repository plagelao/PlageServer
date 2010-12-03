require 'server/application_parser'
require 'URI'

class RequestLineParser
  METHODS = ['GET']
  HTTP_1_1 = "HTTP/1.1"

  def initialize(options = {:application_parser => ApplicationParser.new})
    @application_parser = options[:application_parser]
  end

  def parse(request_string)
    @words = request_line_from(request_string).split
    yield application if contains_valid_method? &&
                         contains_valid_uri?(request_string) &&
                         contains_http11?
  end

  def request_line_from(request_string)
    request_string.split(RequestParser::CRLF).at(0)
  end

  def contains_valid_method?
    METHODS.include?@words.at(0)
  end

  def contains_valid_uri?(request_string)
     (contains_absolute_path? && contains_host_header?(request_string)) || contains_absolute_uri?
  end

  def contains_absolute_path?
    @words.at(1).start_with?"/"
  end

  def contains_host_header?(request_string)
    request_string.split("\r\n").each do |header|
      return true if header.split.at(0) == 'Host:'
    end
    false;
  end

  def contains_absolute_uri?
     uri = URI.parse(@words.at(1))
     uri.is_a?(URI::HTTP) && uri.host== 'localhost' && uri.port == 8082
  end

  def contains_http11?()
    @words.at(2) == HTTP_1_1
  end

  def application
    @application_parser.parse @words.at(1)
  end

end
