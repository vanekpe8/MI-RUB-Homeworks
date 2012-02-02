module MinimalCoverageProblem
  
  #This class contains commons for InputInstance and ResultInstance classes.
  class BasicInstance
    #Creates new instance of BasicInstance with empty fragments array
    def initialize
      @fragments = []
    end
    
    #Adds the given fragment to this instance.
    def addFragment(fragment)
      @fragments[@fragments.count] = fragment
    end
    
    #Removes all fragments from this instance
    def clear
      @fragments = []
    end
    
    #Fragments in this instance
    attr_reader :fragments
  end

  #This class represents an input instance of the problem. Each input instance must have its fragments and "m" attribute specified.
  class InputInstance < BasicInstance
    alias :baseInit :initialize
    
    #Creates new instance of InputInstance with attribute "m" set to 0. 
    def initialize
      baseInit
      @m = 0
    end
    
    #Right end of the interval to cover (Left end is always 0).
    attr_accessor :m
  end
  
  #This class represents an instance of results. Result format is similar to input instance, but it has number of used fragments instead of "m" attribute.
  class ResultInstance < BasicInstance
    alias :baseInit :initialize
    #Creates new instance of ResultInstance - initialization is same as for BasicInstance.
    def initialize
      baseInit
    end

    #Gets the number of used fragments.
    def solutions
      @fragments.count
    end
  end
end
