module Pentomino
  #This module contains classes related to pentomino pieces
  module Pieces
    
    #This class represents one pentomino piece
    class Piece
      #Creates a new instance of Piece
      def initialize
        @placed = false
        @variants = []
      end
      
      #Adds a new variant to this Piece and ensures its uniqueness.
      def addVariant(variant)
        @variants.each do |presentVariant|
          return false if presentVariant == variant
        end
        @variants[@variants.count] = variant
        true
      end
      
      #Creates a deep copy of this Piece, but with different id.
      def cloneWithNewID(id)
        result = Piece.new
        @variants.each do |variant|
          result.addVariant(variant.cloneWithNewID(id))
        end
        result
      end
      
      
      
      #Is this piece placed?
      attr_accessor :placed
      #An array of distinct variants of this piece
      attr_reader :variants
    end
    
    #This class represents a configuration variant of a Piece.
    class PieceVariant
      #Creates a new instance of PieceWariant
      def initialize(width, height)
        @width = width
        @height = height
        @configuration = []
        @width.times do |idx|
          @configuration[idx] = []
        end
      end
      
      #This method fills the configuration grid from the bottom left to the top right corner. Parameter 'tokens' must
      #be an array of numbers, its length must be equal to multiplication of this PieceVariant width and height. Allowed values
      #are 0 and 1. 'id' will be placed to such positions in the configuration grid, that correspond to some 1 in the 'tokens' array.
      #Remaining positions will be filled by 0. This is due to recognition of placed pieces when the result of pentomino is visualized.
      def fill(tokens, id)
        raise "PieceVariant: Invalid number of tokens given (needed #{@width * @height}, given #{tokens.length})" if(tokens.length != @width * @height)
        @height.times do |hIdx|
          @width.times do |wIdx|
            @configuration[wIdx][hIdx] = tokens[hIdx*@width + wIdx] * id
          end
        end
      end 
      
      #This mehod 'rotates the piece clockwise' (creates clockwise rotated image of this PieceVariant).
      def rotate
        rotated = PieceVariant.new(@height, @width)
        @height.times do |hIdx|
          (@width - 1).downto(0) do |wIdx|
            rotated.configuration[hIdx][@width - wIdx - 1] = @configuration[wIdx][hIdx]
          end
        end
        rotated
      end
      
      #This method 'flips the piece' (creates a mirror image of this PieceVariant)
      def flip
        flipped = PieceVariant.new(@width, @height)
        @height.times do |hIdx|
          @width.times do |wIdx|
            flipped.configuration[wIdx][hIdx] = @configuration[@width - wIdx - 1][hIdx]
          end
        end
        flipped
      end
      
      #Returns true if this PieceVariant is equal to the 'other'.
      def ==(other)
        if(other.instance_of?(PieceVariant))
          @configuration == other.configuration
        else
          false
        end
      end
      
      #Returns true if this PieceVariant is equal to the 'other'.
      def eql?(other)
        self == other
      end
      
      #Creates a deep copy of this PieceVariant
      def clone
        result = PieceVariant.new(@width, @height)
        @height.times do |hIdx|
          @width.times do |wIdx|
            result.configuration[wIdx][hIdx] = @configuration[wIdx][hIdx]
          end
        end
        result
      end
      
      #Creates a deep copy of this PieceVariant with different piece ID
      def cloneWithNewID(id)
        result = PieceVariant.new(@width, @height)
        @height.times do |hIdx|
          @width.times do |wIdx|
            if(@configuration[wIdx][hIdx] != 0)
              result.configuration[wIdx][hIdx] = id
            else
              result.configuration[wIdx][hIdx] = 0
            end
          end
        end
        result
      end
      
      def printVariant
        (@height - 1).downto(0) do |hIdx|
        line = ""
        @width.times do |wIdx|
          line += "#{@configuration[wIdx][hIdx]} "
        end
        print line
      end
      end
      
      #Width of configuration grid
      attr_reader :width
      #Height of configuration grid
      attr_reader :height
      #Configuration grid (2D array)
      attr_accessor :configuration
    end
  
  
    #This class is used to keep track of placed and not placed pieces
    class PieceHolder
      #Creates a new instance of PieceHolder. Parateter 'pieces' is supposed to be an array of Piece instances.
      def initialize(pieces, grid_width, grid_height)
        @widths = []
        (grid_width+1).times do |idx|
          @widths[idx] = 0
        end
        @grid_width = grid_width
        @grid_height = grid_height
        @max_width = 0
        @pieces = pieces
        precalculate_max_width(pieces)
      end
      
      #Sets the given 'piece' as used and updates the maximum width and piece's attribute 'placed'.
      #The maximum width is always the greatest width or height among all unused pieces.
      def set_used(piece)
        var = piece.variants[0]
        if(var.height >= var.width)
          max = var.height
          min = var.width
        else
          max = var.width
          min = var.height
        end
        @widths[min] -= 1 if min != max
        @widths[max] -= 1
        piece.placed = true
        if(@widths[@max_width] == 0)
          changed = false
          (@max_width - 1).downto(0) do |index|
            if(@widths[index] > 0)
              @max_width = index
              changed = true
              break
            end
          end
          @max_width = 0 if !changed
        end
      end
      
      #Sets the given 'piece' as unused and updates the maximum width and piece's attribute 'placed'.
      #The maximum width is always the greatest width or height among all unused pieces.
      def set_unused(piece)
        var = piece.variants[0]
        @max_width = var.width if var.width > @max_width
        @max_width = var.height if var.height > @max_width
        @widths[var.width] += 1
        @widths[var.height] += 1 if var.height != var.width
        piece.placed = false
      end
      
      private
      
      #Performs initial pre-calculations. Further updates are trivial.
      def precalculate_max_width(pieces)
        
        pieces.each do |piece|
          
          raise "A Piece must have at least one variant" if piece.variants.count == 0
          var = piece.variants[0]
          raise "A piece cannot have a zero area." if(var.width == 0 || var.height == 0)
          raise "Piece with 'width' = #{var.width} and 'height' = #{var.height} cannot possibly fit into the grid." if((@grid_width >= @grid_height && var.width >= var.height && (var.width > @grid_width || var.height > @grid_height)) ||
                                                                                                                   (@grid_width < @grid_height && var.width < var.height && (var.width > @grid_width || var.height > @grid_height)) ||
                                                                                                                   (@grid_width >= @grid_height && var.width < var.height && (var.height > @grid_width || var.width > @grid_height)) ||
                                                                                                                   (@grid_width < @grid_height && var.width >= var.height && (var.height > @grid_width || var.width > @grid_height)))
          set_unused(piece)
        end
      end
      
      public
      
      #Current maximum width among all unused pieces.
      attr_reader :max_width
      
      #Current array of pieces.
      attr_reader :pieces
      
      private
      
      #An array that keeps track of widths. Its contents should not be changed externaly.
      attr_reader :widths
    end
  end
end

#h = 3
#w = 2
#h.times do |hidx|
#  (w - 1).downto(0) do |widx|
#    puts "[#{widx}][#{hidx}] => [#{hidx}][#{w - widx - 1}]"
#  end
#end
