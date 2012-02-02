require_relative '../lib/Squares.rb'

#Hlavní modul domácí úlohy č. 4. Cílem je najít obsah sjednocení dvou čtverců.
module Squares

  #This class encapsulates the main entry point to the application
  class MainClass
    
    
  
    #Calculates union of two squares
    def run
      messages = []
      messages[0] = "Zadejte delku hrany prvniho ctverce: "
      messages[1] = "Zadejte x-ovou souradnici stredu prvniho ctverce: "
      messages[2] = "Zadejte y-ovou souradnici stredu prvniho ctverce: "
      messages[3] = "Zadejte delku hrany druheho ctverce: "
      messages[4] = "Zadejte x-ovou souradnici stredu druheho ctverce: "
      messages[5] = "Zadejte y-ovou souradnici stredu druheho ctverce: "

      begin
        s1 = read_input(0, messages)
        s2 = read_input(3, messages)
      rescue Exception => ex
        puts "An error occured: #{ex.message}"
        exit
      end
      
      intersect = s1.intersection(s2)
      
      if(intersect == 0)
        puts "Ctverce se ani nedotykaji."
        exit
      end
      
      union = s1.area + s2.area - intersect
      
      puts "Obsah sjednoceni dvou ctvercu je #{union}."
    end
    
    private
    
    #Returns true if variable is a number
    def is_number?(variable)
      true if Float(variable) rescue false
    end
    
    #Asks user for input, reads it and returns an instance of Square
    def read_input(index, messages)
      start = index
      numbers = []
      start.upto(index+2) do |i|
        print messages[i]
        numbers[i - start] = gets.chomp
        if(!is_number?(numbers[i-start]) ||(i == start && Float(numbers[i-start]) < 0))
          raise "Invalid input"
        end
        numbers[i - start] = Float(numbers[i - start])
      end
      Square.new(numbers[1], numbers[2], numbers[0])
    end
  end
end

include Squares

main = MainClass.new
main.run
