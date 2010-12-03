require 'URI'

class RequestParser

  CRLF = "\r\n"
  HEADERS = ['Host', 'User-Agent', 'Accept', 'Accept-Language', 'Accept-Encoding', 'Connection']

  def initialize(options = {:request_line_parser => RequestLineParser.new})
    @parser = options[:request_line_parser]
  end

  def parse(request_string)
    @parser.parse(request_string) do |application|
      yield application
    end if ends_with_crlf?(request_string) &&
           are_all_headers_valid?(request_string)
  end

  def ends_with_crlf?(request_string)
    request_string.end_with?(CRLF*2)
  end

  def are_all_headers_valid?(request_string)
    headers = request_string.split(CRLF)[1..-1]
    headers.each do |header|
      return false unless HEADERS.include?(header.split(":").at(0))
    end
    true
  end

end

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
     URI.parse(@words.at(1)).is_a?(URI::HTTP)
  end

  def contains_http11?()
    @words.at(2) == HTTP_1_1
  end

  def application
    @application_parser.parse @words.at(1)
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
