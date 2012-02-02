require_relative '../lib/CoverageSolver.rb'

#This module contains tools for solving minimal coverage problem, given as follows:<br/>
#"Given an interval <0,M> and a set of X-axis line fragments (each having its left and right end X-coordinates), choose minimal amount of line fragments, that will cover the given interval."
module MinimalCoverageProblem

  #This class encapsulates main entry point to the application
  class MinimalCoverage
    
    #This method is the main entry point to the application
    def run
      if(ARGV.count != 1)
        puts "Application needs only one argument - path to the input file."
      else
        begin
          solver = CoverageSolver.new(ARGV[0])
          results = solver.run
          len = results.count
          len.times do |index|
            result = results[index]
            print_result(result)
            puts "" if(index < len - 1)
          end
        rescue Exception => ex
          puts "An error occured: #{ex.message}"
        end
      end
    end
    
    private
    
    #This method prints a single instance of ResultInstance class
    def print_result(result)
      puts result.solutions
      result.fragments.each do |fragment|
        puts fragment
      end
    end
  end
end

include MinimalCoverageProblem

main = MinimalCoverage.new
main.run
