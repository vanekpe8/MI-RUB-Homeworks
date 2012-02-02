require_relative '../lib/Fragments.rb'
require_relative '../lib/Instances.rb'
require_relative '../lib/InputLoader.rb'
require_relative '../lib/CoverageSolver.rb'
require 'test/unit'

include MinimalCoverageProblem

#This class contains various tests for Fragment class
class FragmentTests < Test::Unit::TestCase
  #Tests Fragment properties
  def test_fragment_properties
    fragment = Fragment.new(- 2, 6)
    assert_equal(- 2, fragment.left)
    assert_equal(6, fragment.right)
    assert_equal(8, fragment.length)
    
    assert_raises(RuntimeError){
      fragment = Fragment.new(6, -2)
    }
  end
  
  #Tests Fragment comparation and sorting
  def test_fragment_comparation
    fragment1 = Fragment.new(- 2, 6)
    fragment2 = Fragment.new(7, 13)
    fragment3 = Fragment.new(4, 22)
    
    assert_equal(- 1, fragment1 <=> fragment2)
    assert_equal(1, fragment2 <=> fragment3)
    arr = [fragment1, fragment2, fragment3]
    assert_equal([fragment1, fragment3, fragment2], arr.sort)
  end
end

#This class contains various tests for BasicInstance and its subclasses
class InstancesTests < Test::Unit::TestCase

  #Tests BasicInstance properties
  def test_BasicInstance
    inst = BasicInstance.new
    f1 = Fragment.new(0,5)
    f2 = Fragment.new(4,10)
    inst.addFragment(f1)
    inst.addFragment(f2)
    assert_equal(2, inst.fragments.count)
    assert_equal(f1, inst.fragments[0])
    assert_equal(f2, inst.fragments[1])
  end
  
  #Tests InputInstance properties
  def test_InputInstance
    inst = InputInstance.new
    inst.m = 10
    assert_equal(10, inst.m)
  end
  
  #Tests ResultInstance properties
  def test_ResultInstance
    inst = ResultInstance.new
    f1 = Fragment.new(0,5)
    f2 = Fragment.new(4,10)
    inst.addFragment(f1)
    inst.addFragment(f2)
    assert_equal(2, inst.solutions)
    inst.clear
    assert_equal(0, inst.solutions)
  end
end

#This class contains various tests for InputLoader class
class InputLoaderTests < Test::Unit::TestCase

  #Tests if InputLoader loads instances correctly
  def test_InputLoader
    il = InputLoader.new(File.new("testInput.txt"))
    assert_equal(true, il.hasNext?)
    inst1 = il.nextInstance
    assert_equal(true, il.hasNext?)
    inst2 = il.nextInstance
    assert_equal(false, il.hasNext?)
    assert_equal(1, inst1.m)
    assert_equal(1, inst2.m)
    assert_equal(3, inst1.fragments.count)
    assert_equal(2, inst2.fragments.count)
  end
end

#This class contains various tests for CoverageSolver class
class SolverTest < Test::Unit::TestCase

  #Tests if CoverageSolver returns correct ResultInstance class instances.
  def test_CoverageSolver
    solver = CoverageSolver.new("input.txt")
    results = solver.run
    assert_equal(2,results.count)
    assert_equal(true, results[0].instance_of?(ResultInstance))
    assert_equal(true, results[1].instance_of?(ResultInstance))
    assert_equal(0,results[0].solutions)
    assert_equal(1,results[1].solutions)
  end
end
