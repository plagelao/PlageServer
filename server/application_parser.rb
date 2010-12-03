require 'server/application'

class ApplicationParser

  def parse uri
    return ApplicationFactory.new.create uri unless absolute_uri?(uri)
    ApplicationFactory.new.create(extract_application uri)
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
