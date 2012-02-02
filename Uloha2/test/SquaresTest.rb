require_relative '../lib/Squares.rb'
require 'test/unit'


module Squares
  
  #This class contains various tests for Squares
  class TestSquares < Test::Unit::TestCase
    
    #Tests properties of Point class
    def test_point
      p = Point.new(3,7)
      assert_equal(3, p.x)
      assert_equal(7, p.y)
    end
  
    #Tests area method of Square class
    def test_square_area
      s = Square.new(0,0,10)
      assert_equal(100, s.area)
    end
    
    #Tests corners method of Square class
    def test_square_corners
      s = Square.new(0,0,10)
      correct_results = [Point.new(-5,-5), Point.new( 5,-5), Point.new(-5,5), Point.new(5,5)]
      results = s.corners
      results.each_with_index do |point, index|
        assert_equal(correct_results[index].x, point.x)
        assert_equal(correct_results[index].y, point.y)
      end
    end
    
    #Tests method contains_point? of Square class
    def test_square_contains_point?
      s = Square.new(0,0,10)
      points_inside = [Point.new(0,0), Point.new(2, -2), Point.new(-5,-5), Point.new(-4,5), Point.new(-2,1)]
      points_outside = [Point.new(-6,-6), Point.new(10,0), Point.new(-7,2), Point.new(0,6), Point.new(6,0), Point.new(0,-6), Point.new(-6,0)]
      points_inside.each do |point|
        assert_equal(true, s.contains_point?(point))
      end
      points_outside.each do |point|
        assert_equal(false, s.contains_point?(point))
      end
    end
    
    #Tests intersection method of Square class
    def test_intersection
      s1 = Square.new(5,5,4)
      s2 = Square.new(5,5,6)
      assert_equal(16, s1.intersection(s2))
      assert_equal(16, s2.intersection(s1))
      
      s1 = Square.new(5,5,4)
      s2 = Square.new(2,2,4)
      assert_equal(1, s1.intersection(s2))
      assert_equal(1, s2.intersection(s1))
      
      s1 = Square.new(5,5,6)
      s2 = Square.new(5,9,4)
      assert_equal(4, s1.intersection(s2))
      assert_equal(4, s2.intersection(s1))
    end
  end

end
