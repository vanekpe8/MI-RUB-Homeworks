require_relative '../lib/Node.rb'
require_relative '../lib/Goal.rb'
require_relative '../lib/Graph.rb'
require_relative '../lib/GraphLoader'
require_relative '../lib/Algorithms.rb'
require_relative '../lib/Queues.rb'
require_relative '../lib/InputLoader.rb'




module Graphs

  #This class encapsulates main entry point to the application
  class MainClass
  
    #This method is the main entry point to the application
    def run
      #load input
      loader = nil
      if(ARGV.count != 1)
        puts "Input file must be specified as the first argument."
        exit
      end
      nARGV = []
      begin
        loader = InputLoader.new(File.new(ARGV[0]))
        nARGV = loader.load
      rescue Exception => ex
        puts "An error occured: #{ex.message}"
        exit
      end
      
      #Create Graph Loader
      noGraphs = Integer(nARGV.shift)
      loader = GraphLoader.new(noGraphs, nARGV)
      
      #for each graph ...
      noGraphs.times do |graph_index|
        puts "graph #{graph_index+1}"
        graph = loader.loadNextGraph
        noGoals = graph.goals.count
        #for each goal ...
        noGoals.times do |goal_index|
          goal = graph.goals[goal_index]
          #puts goal
          
          algorithm = goal.algorithm
          algorithm.init(graph, goal.startNodeID)
          algorithm.run
          print "\n"
        end
      end
    end
  
  end

end

include Graphs

main = MainClass.new
main.run
