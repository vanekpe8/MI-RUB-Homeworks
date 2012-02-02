#This module contains tools to handle input of this application. That includes parsing command line arguments or reading data file
module Input

  #This class handles file reading
  class InputLoader
    #Creates new instance of InputLoader, given a file to read
    def initialize(file)
      @file = file
    end
    
    #This method could be used to determine if the input is read completely
    def done?
      @file.eof?
    end
    #Reads next line from the file. This may throw an exception when end of file is reached. To avoid this, try calling InputLoader#done? before this method.
    def nextLine
      @file.readline.chomp
    end
    
  end
  
  #This class handles parsing of command line
  class ArgumentsParser
    #Creates new instance of ArgumentsParser and sets the encryption / decryption key to default_key value
    def initialize(default_key)
      @key = default_key
      @show_help = false
      @file = nil
      @encrypt = false
    end
    
    #This method, given an array of command line arguments, parses any number of arguments and sets all class variables.
    def parse(argv)
      len = argv.count
      if(len == 0)
        @show_help = true
        return
      end
      index = 0
      begin
        arg = argv[index]
        if(arg == "-k" || arg == "--key")
          raise 'Key value must be specified after "-k" or "--key" switch.' if(index == len-1)
          @key = Integer(argv[index+1])
          index = index + 1
        elsif(arg == "-h" || arg == "--help")
          @show_help = true
        elsif(arg == "-e" || arg == "--encrypt")
          @encrypt = true
        else
          @file = File.new(arg)
        end
        index = index + 1
      end while(index < len)
    end
    
    #Encryption / decryption key.
    attr_reader :key
    #This attribute tells its caller, if the help should be shown.
    attr_reader :show_help
    #A text file which contents are to be decrypted (or encrypted eventualy).
    attr_reader :file
    #This attribute tells its caller, if the given file should be encrypted (if not, it should be decrypted).
    attr_reader :encrypt
  end
end
