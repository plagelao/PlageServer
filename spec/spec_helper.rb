$: << File.expand_path(File.dirname(__FILE__)  + "/..")
require 'rspec'

Dir.new(File.expand_path(File.dirname(__FILE__))).each do |filename|
  require "spec/" + filename.slice(0...-3) unless filename.start_with?(".")
end

