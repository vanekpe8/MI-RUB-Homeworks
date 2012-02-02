require_relative 'Node.rb'
require_relative 'Goal.rb'
require_relative 'Graph.rb'
require_relative 'GraphLoader'
require_relative 'Algorithms.rb'
require_relative 'Queues.rb'


module Graphs

  #This class is responsible for reading input file
  class InputLoader
    #Creates a new instance of InputLoader with a file specified
    def initialize(file)
      raise "Invalid file type" if (!file.respond_to?(:readline) ||
                                    !file.respond_to?(:eof?) ||
                                    !file.respond_to?(:close))
      @file = file
    end
    
    #Returns an array of input data (splited by words)
    def load
      arr = []
      begin
        while(!@file.eof?)
          line = @file.readline.chomp
          arr.concat(line.split)
        end
      ensure
        @file.close
      end
      arr
    end
    
    
  end
end
