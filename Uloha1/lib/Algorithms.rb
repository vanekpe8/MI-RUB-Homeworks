require_relative 'Node.rb'
require_relative 'Graph.rb'

module Graphs

  #This class implements Deep-First Search algorithm
  class DFSAlgorithm
  
    #Creates new instance of DFSAlgorithm
    def initialize
      @queue = DFSQueue.new
    end
    
    #Initializes the algorithm on given graph and given start node
    def init(graph, startNodeID)
      @start = graph.getNode(startNodeID)
      
      graph.nodeArray.each do |node|
        node.state = 0 # FRESH
        node.iterationIndex = 0;
      end
    end
    
    #Runs the algorithm
    def run
      @queue.enqueue(@start)
      print @start
      @start.state = 1
      while (node = @queue.dequeue) != nil
        tmp = node.getNextAdjacentNode # this wont be nil (guaranteed by the queue)
        #enqueue node, if it is still FRESH
        if tmp.state == 0
          print " #{tmp}"
          tmp.state = 1
          @queue.enqueue(tmp)
        end
      end
    end
  end
  
  #This class implements Breadth-First Search algorithm
  class BFSAlgorithm
    #Creates new instance of BFSAlgorithm
    def initialize
      @queue = BFSQueue.new
    end
    
    #Initializes the algorithm on given graph and given start node
    def init(graph, startNodeID)
      @start = graph.getNode(startNodeID)
      graph.nodeArray.each do |node|
        node.state = 0 # FRESH
        node.iterationIndex = 0;
      end
    end
    
    #Runs the alogorithm
    def run
      @queue.enqueue([@start])
      index = 0
      while !@queue.empty?
        node = @queue.dequeue
        node.state = 2 # CLOSED
        print ' ' if index > 0
        index = index + 1
        print node.id
        @queue.enqueue(node.adjacents)
      end
    end
  end

end
