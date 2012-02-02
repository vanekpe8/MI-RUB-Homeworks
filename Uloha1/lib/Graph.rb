require_relative 'Node.rb'
require_relative 'Goal.rb'

module Graphs
  #This class represents a graph
  class Graph
    #Creates new instance of Graph
    def initialize(numberOfNodes)
      @n = numberOfNodes
      @goals = []
      @nodeArray = []
      @n.times do |index|
        @nodeArray[index] = Node.new(index+1)
      end
    end
    
    #Adds a transition from source node to destination node
    def addTransition(sourceNodeID, destNodeID)
      @nodeArray[sourceNodeID - 1].addAdjacentNode(@nodeArray[destNodeID - 1])
    end
    
    #Adds a Goal to this graph. That means a pair of start node and algorithm to use.
    def addGoal(goal)
      @goals[@goals.count] = goal
    end
    
    #Returns node by its id
    def getNode(id)
      @nodeArray[id-1]
    end
    #Nodes in this graph
    attr_reader :nodeArray
    #Size of this graph (number of nodes)
    attr_reader :n
    #Goals for this graph
    attr_reader :goals
  end

end
