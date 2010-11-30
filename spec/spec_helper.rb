require 'rspec'
Dir.glob("*.rb") do |filename| 
  require File.expand_path(filename)
end

