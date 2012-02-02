require_relative 'Node.rb'
require_relative 'Goal.rb'
require_relative 'Graph.rb'
require_relative 'Algorithms.rb'
require_relative 'Queues.rb'
require_relative 'InputLoader.rb'

module Graphs
  #This class is responsible for creating Graphs
  class GraphLoader
    #Creates a new instance of GraphLoader, given number of graphs to create and array of data to create them
    def initialize(numberOfGraphs, argv)
      @numberOfGraphs = numberOfGraphs
      @argv = argv
    end
    
    #Returns an instance of Graph created from the data given to this GraphLoader in initialization
    def loadNextGraph
        nc = Integer(@argv.shift) # nodes count
        graph = Graph.new(nc)
        nc.times do
          sourceNodeID = Integer(@argv.shift)
          adjCount = Integer(@argv.shift)
          adjCount.times do
            destNodeID = Integer(@argv.shift)
            graph.addTransition(sourceNodeID, destNodeID)
          end
        end
        startNodeID = Integer(@argv.shift)
        algID = Integer(@argv.shift)
        begin
          if(algID == 0)
            algorithm = DFSAlgorithm.new
          else
            algorithm = BFSAlgorithm.new
          end
          graph.addGoal(Goal.new(startNodeID, algorithm))
          startNodeID = Integer(@argv.shift)
          algID = Integer(@argv.shift)
        end while startNodeID != 0
        graph
    end
  end

end
