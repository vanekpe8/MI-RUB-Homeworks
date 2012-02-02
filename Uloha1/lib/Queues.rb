require_relative 'Node.rb'

module Graphs
  #Deep-First Search Queue, implemented as a stack.
  class DFSQueue
    #Creates new instance of DFSQueue
    def initialize
      @queue = []
    end
    
    #Enqueue adds given node to the queue
    def enqueue(node)
      @queue[@queue.count] = node
    end
    
    #Dequeue returns next element, with hasNextAdjacentNode? == true, or nil if no such element is in the queue
    def dequeue
      node = @queue[-1] # last element
      while !node.hasNextAdjacentNode?
        node.state = 2 # CLOSED
        @queue.delete_at(-1)
        if @queue.count == 0
          node = nil
          break
        else
          node = @queue[-1]
        end
      end
      node
    end
    
    #This method tells its caller if this queue is empty
    def empty?
      @queue.count == 0
    end
  end
  
  #Breadth-First Search Queue, implemented as a Queue
  class BFSQueue
    #Creates new instance of BFSQueue
    def initialize
      @queue = []
    end
    
    #Enqueue adds given nodes to the queue
    def enqueue(nodes)
      nodes.each do |node|
        if node.state == 0
          @queue[@queue.count] = node
          node.state = 1 # OPENED
        end
      end
    end
    
    #Dequeue gets first element from the queue
    def dequeue
      @queue.delete_at(0)
    end
    
    #This method tells its caller if this queue is empty
    def empty?
      @queue.count == 0
    end
  end

end
