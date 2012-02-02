require_relative 'Goal.rb'
require_relative 'Graph.rb'
require_relative 'GraphLoader'
require_relative 'Algorithms.rb'
require_relative 'Queues.rb'
require_relative 'InputLoader.rb'

module Graphs
  #This class represents a node in graph
  class Node
    #Creates new instance of Node
    def initialize(id)
      @id = id
      @adjacents = []
      @state = 0 #FRESH
      @iterationIndex = 0
    end
    
    #Adds given node to neighbours list
    def addAdjacentNode(node)
      @adjacents[@adjacents.count] = node
    end
    
    #Tells its caller if there is another node in the neigbours list, that has not been used yet
    def hasNextAdjacentNode?
      @iterationIndex < @adjacents.count
    end
    
    #Gets next node from the neighbours list
    def getNextAdjacentNode
      item = nil
      item = @adjacents[@iterationIndex] if @iterationIndex < @adjacents.count
      @iterationIndex = @iterationIndex + 1
      item
    end
    
    #Gives a string representation of this node
    def to_s
      "#{@id}"
    end
    #ID of this node
    attr_reader :id
    #Neighbours list
    attr_reader :adjacents
    #Current state of this node
    attr_accessor :state
    #Index used to iterate through neighbours list (set to 0 for reseting search)
    attr_accessor :iterationIndex
  end

end
