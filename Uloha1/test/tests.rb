require_relative '../lib/InputLoader.rb'
require 'test/unit'

module Graphs
  #This class contains variouts tests for InputLoader class
  class InputLoaderTests < Test::Unit::TestCase
    #Tests correct input loading
    def test_InputLoader
      loader = InputLoader.new(File.new('input.txt'))
      assert_equal(["1", "2", "3", "4", "5", "6"], loader.load)
    end
  end

end
