require_relative 'Algorithms.rb'

module Graphs
  #This class stores a goal for a graph
  class Goal
    #Creates new instance of Goal with specified start node (by its ID) and an algorithm
    def initialize(startNodeID, algorithm)
      @startNodeID = startNodeID
      @algorithm = algorithm
    end
    #ID of graph seach start node
    attr_reader :startNodeID
    #Algorithm to use to accomplish this goal
    attr_reader :algorithm
  end

end
