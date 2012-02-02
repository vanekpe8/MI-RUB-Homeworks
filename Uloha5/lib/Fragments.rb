module MinimalCoverageProblem

  #This class represents X-axis line fragment. Each fragment is specified by its left end X-coordinate and its right end X-coordinate.
  class Fragment
    #Creates new instance of fragment with given left end and right end (in the X-axis). Its "left" end must not be greater than its "right" end.
    def initialize(left, right)
      raise "Fragment: 'left' (#{left}) cannot be greater than 'right' (#{right})." if left > right
      @left = left
      @right = right
      @length = right - left
    end
    
    #A comparator for sorting
    def <=>(other)
      @left <=> other.left
    end
    
    #Returns string representation of this Fragment
    def to_s
      "#{@left} #{@right}"
    end
    
    #Left end of the fragment
    attr_reader :left
    
    #Rigth end of the fragment
    attr_reader :right
    
    #Length of the fragment
    attr_reader :length
  end
end
