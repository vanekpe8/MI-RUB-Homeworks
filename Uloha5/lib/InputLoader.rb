require_relative 'Instances.rb'

module MinimalCoverageProblem
  #This class is responsible for creating InputInstances. The input is loaded from a file.
  class InputLoader
    #Creates new instance of InputLoader. "file" is a text file which contains input data.
    def initialize(file)
      raise "Invalid file type." if(!file.respond_to?(:close) || !file.respond_to?(:readline) || !file.respond_to?(:eof?))
      @file = file
      @instances_count = Integer(file.readline)
    end
    
    #This method tells its caller, if this InputLoader instance has more instances to produce.
    def hasNext?
      @instances_count > 0
    end
    
    #This method gets next InputInstance from the input file. Be sure to call InputLoader#hasNext? before calling this to determine, if this method may be called or not.
    def nextInstance
      #ignore empty lines
      str = ""
      begin
        str = @file.readline.chomp.delete(" ")
      end while str == ""
      #create new instance
      inst = InputInstance.new
      #set m
      inst.m = Integer(str)
      #add fragments
      arr = getNextLine
      while(arr != ["0", "0"])
        left = Integer(arr[0])
        right = Integer(arr[1])
        inst.addFragment(Fragment.new(left,right))
        arr = getNextLine
      end
      #decrease instances_count
      @instances_count = @instances_count - 1
      #return instance
      inst
    end
    
    #Closes the file
    def close
      @file.close
    end
    
    private
    
    #This method reads line from the file and splits it to words. Those words are then returned as an array.
    def getNextLine
      str = @file.readline.chomp
      str.split
    end
  end
end



