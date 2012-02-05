require_relative '../lib/Pieces.rb'
require_relative '../lib/InputLoader.rb'
require_relative '../lib/Grid.rb'
require_relative '../lib/PentominoSolver.rb'

require 'test/unit'


module Pentomino
  #This module contains unit tests for this Pentomino project.
  module Tests

    #This class contains various tests for pentomino Pieces
    class PieceTests < Test::Unit::TestCase
      include Pentomino::Pieces
      
      def test_piece_properties
        p = Piece.new
        assert_equal(false, p.placed)
        assert_equal([], p.variants)
      end
      
      def test_piece_variant_properties
        pv = PieceVariant.new(2,3)
        assert_equal(2, pv.width)
        assert_equal(3, pv.height)
      end
      
      def test_piece_variant_rotation
        pv = PieceVariant.new(2,3)
        pv.fill([1,0,1,0,1,1],1) #fill with L (2x3)
        assert_equal([[1,1,1],[0,0,1]], pv.configuration)
        rot = pv.rotate
        assert_equal(3, rot.width)
        assert_equal(2, rot.height)
        assert_equal([[0,1],[0,1],[1,1]], rot.configuration)
      end
      
      def test_piece_variant_equality
        pv1 = PieceVariant.new(2,3)
        pv1.fill([1,0,1,0,1,1],1)
        pv2 = PieceVariant.new(3,2)
        pv2.fill([1,1,1,1,0,0],1)
        refute_equal(pv1,pv2)
        pv3 = pv2.rotate
        assert_equal(pv1,pv3)
        assert_equal(true, pv1 == pv3)
        assert_equal(true, pv1.eql?(pv3))
        assert_equal(false, pv1.equal?(pv3))
        pv4 = pv1.clone
        assert_equal(true, pv1 == pv4)
        assert_equal(false, pv1.equal?(pv4))
      end
      
      def test_piece_variant_flip
        pv1 = PieceVariant.new(2,3)
        pv1.fill([1,0,1,0,1,1],1)
        pv2 = pv1.flip
        assert_equal([[0,0,1],[1,1,1]], pv2.configuration)
      end
      
      def test_piece_add_variant
        pv1 = PieceVariant.new(2,3)
        pv1.fill([1,0,1,0,1,1],1)
        p = Piece.new
        p.addVariant(pv1)
        assert_equal(1, p.variants.count)
        pv = pv1.rotate
        p.addVariant(pv)
        assert_equal(2, p.variants.count)
        pv = pv.rotate
        p.addVariant(pv)
        assert_equal(3, p.variants.count)
        pv = pv.rotate
        p.addVariant(pv)
        assert_equal(4, p.variants.count)
        pv = pv.rotate
        p.addVariant(pv)
        assert_equal(4, p.variants.count)
        pv = pv.rotate
        p.addVariant(pv)
        assert_equal(4, p.variants.count)
      end
      
      def test_piece_clone
        p = Piece.new
        pv = PieceVariant.new(2,3)
        pv.fill([1,0,1,0,1,1],1)
        p.addVariant(pv)
        assert_equal([[1,1,1],[0,0,1]],p.variants[0].configuration)
        pClone = p.cloneWithNewID(2)
        assert_equal([[2,2,2],[0,0,2]], pClone.variants[0].configuration)
      end
    end
    
    #This class contains various tests for pentomino Input and InputLoader classes
    class InputTests < Test::Unit::TestCase
      include Pentomino::InputHandling
      
      def test_input
        i = Input.new
        i.width = 4
        i.height = 3
        i.addPiece(Piece.new)
        assert_equal(4, i.width)
        assert_equal(3, i.height)
        assert_equal(1, i.pieces.count)
      end
      
      def test_input_loading
        i = Input.new
        loader = InputLoader.new(File.new("testInput.txt"))
        loader.load(i)
        assert_equal(4, i.width)
        assert_equal(3, i.height)
        assert_equal(4, i.pieces.count)
        assert_equal(4, i.pieces[0].variants.count)
      end
    end
    
    #This class contains various tests for Grid class
    class GridTests < Test::Unit::TestCase
      
      def test_grid_properties
        grid = Grid.new(2,2)
        assert_equal(2, grid.width)
        assert_equal(2, grid.height)
        assert_equal([[0,0],[0,0]], grid.grid)
      end
      
      def test_grid_can_place
        g1 = Grid.new(2,2)
        g1.grid[0][1] = 2
        assert_equal([[0,2],[0,0]], g1.grid)
        g2 = Grid.new(2,2)
        g2.grid[1][1] = 2
        assert_equal([[0,0],[0,2]],g2.grid)
        var = Pentomino::Pieces::PieceVariant.new(2,2)
        var.fill([1,1,1,0],1)
        assert_equal(false, g1.can_place?(var,1,0))
        assert_equal(true, g2.can_place?(var,1,0))
        g2.place(var,1,0)
        assert_equal([[1,1],[1,2]], g2.grid)

      end
      
    end
    
    #This class contains various tests for PentominoSolver class
    class SolverTests < Test::Unit::TestCase

      def test_find_first_empty_cell
        g = Pentomino::Grid.new(3,3)
        var = Pentomino::Pieces::PieceVariant.new(3,2)
        var.fill([1,1,1,1,0,0],1)
        assert_equal([[1,1],[1,0],[1,0]],var.configuration)
        g.place(var,2,0)
        solver = PentominoSolver.new(g,[])
        assert_equal(4, solver.send(:find_first_empty_cell, g, 0))
        assert_equal(4, solver.send(:find_first_empty_cell, g, 2))
      end
      
      def test_recursion
        g = Pentomino::Grid.new(2,2)
        pieces = []
        pieces[0] = Pentomino::Pieces::Piece.new
        pieces[1] = Pentomino::Pieces::Piece.new
        
        v1 = Pentomino::Pieces::PieceVariant.new(1,1)
        v1.fill([1],1)
        v2 = Pentomino::Pieces::PieceVariant.new(2,2)
        v2.fill([1,0,1,1],2)
        pieces[0].addVariant(v2)
        pieces[0].addVariant(v2.rotate)
        pieces[0].addVariant(v2.rotate.rotate)
        pieces[0].addVariant(v2.rotate.rotate.rotate)
        assert_equal(4, pieces[0].variants.count)
        pieces[1].addVariant(v1)
        solver = Pentomino::PentominoSolver.new(g, pieces)
        solver.run
        assert_equal([[1,2],[2,2]], solver.result.grid)
        
      end
    end
    
    #This class contains various tests for PieceHolder class
    class PieceHolderTests < Test::Unit::TestCase
      def test_piece_holder
        pieces = []
        
        pieces[0] = Pentomino::Pieces::Piece.new
        pieces[1] = Pentomino::Pieces::Piece.new
        pieces[2] = Pentomino::Pieces::Piece.new
        
        pieces[0].addVariant(Pentomino::Pieces::PieceVariant.new(3,2))
        pieces[1].addVariant(Pentomino::Pieces::PieceVariant.new(3,6))
        pieces[2].addVariant(Pentomino::Pieces::PieceVariant.new(4,2))
        
        assert_raises(RuntimeError){
          holder = Pentomino::Pieces::PieceHolder.new(pieces,5,5)
        }
        holder = Pentomino::Pieces::PieceHolder.new(pieces,8,8)
        assert_equal([0,0,2,2,1,0,1,0,0], holder.send(:widths))
        assert_equal(6, holder.max_width)
        holder.set_used(pieces[1])
        assert_equal([0,0,2,1,1,0,0,0,0], holder.send(:widths))
        assert_equal(4, holder.max_width)
        holder.set_used(pieces[0])
        assert_equal([0,0,1,0,1,0,0,0,0], holder.send(:widths))
        assert_equal(4, holder.max_width)
        holder.set_used(pieces[2])
        assert_equal([0,0,0,0,0,0,0,0,0], holder.send(:widths))
        assert_equal(0, holder.max_width)
        holder.set_unused(pieces[1])
        assert_equal([0,0,0,1,0,0,1,0,0], holder.send(:widths))
        assert_equal(6, holder.max_width)
        holder.set_unused(pieces[0])
        assert_equal([0,0,1,2,0,0,1,0,0], holder.send(:widths))
        assert_equal(6, holder.max_width)
        pieces[3] = Pentomino::Pieces::Piece.new
        assert_raises(RuntimeError){
          holder = Pentomino::Pieces::PieceHolder.new(pieces,8,8)
        }
        pieces[3].addVariant(Pentomino::Pieces::PieceVariant.new(3,0))
        assert_raises(RuntimeError){
          holder = Pentomino::Pieces::PieceHolder.new(pieces,8,8)
        }
      end
    end
    
  end
end
