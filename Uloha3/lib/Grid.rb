module Pentomino
  #This class represents pentomino grid
  class Grid
    #Creates a new instance of Grid with given width and height
    def initialize(width, height)
      @width = width
      @height = height
      @grid = []
      @width.times do |wIdx|
        @grid[wIdx] = []
        @height.times do |hIdx|
          @grid[wIdx][hIdx] = 0
        end
      end
    end
    
    #Given a PieceVariant, and a point [x,y], this method determines
    #whether given PieceVariant can be placed into the grid, such that
    #its bottom right corner is in the point [x,y].
    def can_place?(piece_variant, x, y)
      if(x+1 < piece_variant.width || y > @height - piece_variant.height)
        false
      else
        piece_variant.width.times do |wIdx|
          col = x - piece_variant.width + wIdx + 1
          piece_variant.height.times do |hIdx|
            return false if(@grid[col][y + hIdx] != 0 && piece_variant.configuration[wIdx][hIdx] != 0)
          end
        end
        true
      end
    end
    
    #This method places a given PieceVariant to the grid, such that its bottom right
    #corner is in the given point [x,y].
    def place(piece_variant, x, y)
      if(x+1 < piece_variant.width || y > @height - piece_variant.height)
        false
      else
        piece_variant.width.times do |wIdx|
          col = x - piece_variant.width + wIdx + 1
          piece_variant.height.times do |hIdx|
            if(piece_variant.configuration[wIdx][hIdx] != 0)
              @grid[col][y + hIdx] = piece_variant.configuration[wIdx][hIdx]
            end
          end
        end
        true
      end
    end
    
    #Creates a deep copy of this Grid
    def clone
      result = Grid.new(@width, @height)
      @width.times do |wIdx|
        @height.times do |hIdx|
          result.grid[wIdx][hIdx] = @grid[wIdx][hIdx]
        end
      end
      result
    end
    
    #Prints the grid to standard output.
    def printGrid(number_of_pieces)
      size = number_of_pieces.to_s.length
      print_horizontal_line((size+1) * @width + 1)
      
      (@height - 1).downto(0) do |hIdx|
        print '|'
        @width.times do |wIdx|
          print fixed_string(@grid[wIdx][hIdx].to_s, size)
          print ' ' if wIdx < @width - 1
        end
        print '|'
        print "\n"
      end
      
      print_horizontal_line((size+1) * @width + 1)
    end
    
    #Width of this Grid.
    attr_reader :width
    
    #Height of this Grid.
    attr_reader :height
    
    #The grid in which pieces are placed.
    attr_accessor :grid
    
    private
    
    #This method formats a string, such that it has a fixed size
    def fixed_string(string, fixedSize)
      len = string.length
      res = ""
      (fixedSize - len).downto(1) do
        res = res + " "
      end
      res = res + string
      res 
    end
    
    #This method prints a horizontal line like for example '+---+' when length = 5.
    def print_horizontal_line(length)
      print '+'
      (length - 2).times do |index|
        print '-'
      end
      print '+'
      print "\n"
    end
    
  end
end
