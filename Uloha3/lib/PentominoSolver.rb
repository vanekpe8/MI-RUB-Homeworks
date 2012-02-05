module Pentomino
  include Pentomino::Pieces
  
  #This class can recursively solve pentomino problem.
  class PentominoSolver
    #Creates a new instance of PentominoSolver for a 'grid' and some 'pieces'.
    def initialize(grid, pieces)
      @grid = grid
      @holder = Pieces::PieceHolder.new(pieces, grid.width, grid.height)
    end
    
    #Runs the solver. Result is stored in 'result' instance variable.
    def run
      @result = recursive_pentomino(@grid, @holder, 0, 0)
    end
    
    #Result Grid of the given problem.
    attr_reader :result
    
    private
    
    #This method recursively finds a solution for pentomino.
    def recursive_pentomino(grid, piece_holder, placed_pieces, check_ptr_addr)
      tmp = find_first_empty_cell(grid, check_ptr_addr)
      checkX = tmp % grid.width
      checkY = tmp / grid.width
      insX = checkX
      insY = checkY
      pieces = piece_holder.pieces
      
      while(insX < grid.width)
        pieces.each do |piece|
          if(!piece.placed)
            piece.variants.each do |variant|
              #puts "--------"
              #variant.printVariant
              #puts "can_place_to(#{insX}, #{insY})? #{grid.can_place?(variant,insX,insY)}"
              
              if(grid.can_place?(variant, insX, insY))
                g1 = grid.clone
                g1.place(variant, insX, insY)
                piece_holder.set_used(piece)
                return g1 if(placed_pieces + 1 == pieces.count)
                result = recursive_pentomino(g1, piece_holder, placed_pieces + 1, checkY * grid.width + checkX)
                if(result == nil)
                  piece_holder.set_unused(piece)
                else
                  return result
                end
              end #end if
            end #end variants.each
          end #end if
        end #end pieces.each
        insX = insX + 1
        return nil if(insX - checkX > piece_holder.max_width) # there is no piece, which could cover the gap between insX and checkX.
      end #end while
      return nil
    end
    
    #This method iterates through the 'grid' from left to right and from the botton to the top, until it finds a cell
    #withe value 0.
    def find_first_empty_cell(grid, address)
      x = address % grid.width
      y = address / grid.width
      #puts "--firstempty------"
      while(y < grid.height)
        while(x < grid.width)
          #puts "x: #{x} y: #{y}"
          if(grid.grid[x][y] == 0)
            #puts "---------------"
            return y*grid.width + x
          end
          x = x + 1
        end
        x = 0
        y = y + 1
      end
      y*grid.width + x
    end
  end
end

