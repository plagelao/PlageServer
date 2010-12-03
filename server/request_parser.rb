require 'server/request_line_parser'

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
      return false unless valid_header?(header)
    end
    true
  end

  def valid_header?(header)
    HEADERS.include?(header.split(":").at(0))
  end
end
