require_relative '../lib/InputLoader.rb'
require_relative '../lib/Grid.rb'
require_relative '../lib/PentominoSolver.rb'

#The main module of the application.
module Pentomino

  #This class encapsulates the main entry point to the application
  class MainClass
    
    #This method is the main entry point to the application
    def run
      begin
        raise "This application needs a path to the input file specified as the first argument." if(ARGV.count < 1)
        input = Pentomino::InputHandling::Input.new
        file = File.new(ARGV[0])
        loader = Pentomino::InputHandling::InputLoader.new(file)
        loader.load(input)
        grid = Grid.new(input.width, input.height)
        solver = PentominoSolver.new(grid, input.pieces)
        solver.run
        if(solver.result == nil)
          puts "No solution found."
        else
          solver.result.printGrid(input.pieces.count)
        end
      rescue Exception => ex
        puts "An error occured: #{ex.message}"
      end
    end
  end
end

include Pentomino

main = MainClass.new
main.run
