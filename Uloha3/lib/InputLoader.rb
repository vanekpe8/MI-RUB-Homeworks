require_relative 'Pieces.rb'

module Pentomino
  #This module contains classes, which store or handle input data.
  module InputHandling
    include Pentomino::Pieces
    
    #This class stores input data for Pentomino.
    class Input
      #Creates a new empty instance of Input.
      def initialize
        @width = 0
        @height = 0
        @pieces = []
      end
      
      #Adds a Piece to this instance of Input.
      def addPiece(piece)
        @pieces[@pieces.count] = piece
      end
      
      #Width of pentomino grid.
      attr_accessor :width
      #Height of pentomino grid.
      attr_accessor :height
      #Pieces to place to the grid.
      attr_accessor :pieces
    end
    
    #This class handles loading input from a file.
    class InputLoader
    
      #Creates a new instance of InputLoader. Parameter file is the input file.
      def initialize(file)
        raise "Invalid file type." if(!file.respond_to?(:close) ||
                                      !file.respond_to?(:readline) ||
                                      !file.respond_to?(:eof?))
        @file = file
      end
      
      #Loads the input from the file given to this InputLoader at initialization
      def load(input)
        begin
          arr = @file.readline.chomp.split
          input.width = Integer(arr[0])
          input.height = Integer(arr[1])
          controlVar = 0
          pieceID = 1
          pTokens = []
          pNumber = 0
          pWidth = 0
          pHeight = 0
          while(!@file.eof?)
            line = @file.readline.chomp
            if(line.delete(" ") == "")#ignore empty lines
              controlVar = 0
              if(pTokens.count > 0)
                createPieces(pieceID, pNumber, pWidth, pHeight, pTokens, input)
                pieceID = pieceID + pNumber
                pTokens = []
              end
            elsif(controlVar == 0)#first line after empty line
              arr = line.split
              pWidth = Integer(arr[0])
              pHeight = Integer(arr[1])
              pNumber = Integer(arr[2])
              pTokens = [] # an array of integers
              controlVar = 1
            else # other lines specify piece configuration grid
              arr = line.split
              arr.each do |token|
                pTokens[pTokens.count] = Integer(token)
              end
            end
          end
          if(pTokens.count > 0)
            createPieces(pieceID, pNumber, pWidth, pHeight, pTokens, input)
          end
        ensure
          @file.close if(@file != nil)
        end
      end
      
      private
      
      #This method creates certain number of same looking pieces.
      def createPieces(initial_id, number_of_pieces, width, height, tokens, input)
        raise "Invalid number of pieces: #{number_of_pieces}" if number_of_pieces < 1
        piece = Pentomino::Pieces::Piece.new
        var = Pentomino::Pieces::PieceVariant.new(width, height)
        var.fill(tokens, initial_id)
        8.times do |index| #piece may have up to 8 variants
          piece.addVariant(var)
          var = var.rotate
          var = var.flip if index == 3
        end
        input.addPiece(piece)
        (number_of_pieces - 1).times do |index|
          piece = piece.cloneWithNewID(initial_id + 1 + index)
          input.addPiece(piece)
        end
      end
    end
  end
end
