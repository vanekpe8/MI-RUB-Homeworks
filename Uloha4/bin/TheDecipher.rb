require_relative '../lib/TheDecipherLibrary.rb'
require_relative '../lib/InputLoader.rb'

include Decipher
include Input

#TheDecipher is a simple cryptographic tool, which allows to decrypt (or encrypt) text files using simple monoalphabetic cipher (a cipher based on shifting each character of plain-text by constant value - the key).
#This class encapsulates the main entry point to the application (method TheDecipher#run)
class TheDecipher

  
  #This method is the main entry point to the application
  def run
    begin
      #parse command line arguments
      parser = ArgumentsParser.new(7)
      parser.parse(ARGV)
      if(parser.show_help)
        #show help if requested
        showHelp
      else
        #parse file
        loader = InputLoader.new(parser.file)
        if(parser.encrypt)
          begin
            puts encrypt(loader.nextLine, parser.key)
          end while !loader.done?
        else
          begin
            puts decrypt(loader.nextLine, parser.key)
          end while !loader.done?
        end
      end
    rescue Exception => ex
      puts "An error occured:\n#{ex.message}"
    ensure
      parser.file.close if(parser.file.instance_of?(File))
    end
  end
  
  private
  
  #This method shows the help to standart output.
  def showHelp
    puts 'Usage:   TheDecipher [inputFile]           => Decrypts given file using default'
    puts '                                              key value 7'
    puts '         TheDecipher [options] [inputFile] => Application behavior depends on'
    puts '                                              used options'
    puts ''
    puts 'Options: -h / --help                 => show this help'
    puts '         -k [value] / --key [value]  => use numeric [value] as decryption'
    puts '                                        (encryption) key (default value = 7)'
    puts '         -e / --encrypt              => encrypt the input (without this switch,'
    puts '                                        application performs decryption)'
  end

end

decipher = TheDecipher.new
decipher.run
