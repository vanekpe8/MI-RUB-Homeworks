require_relative 'InputLoader.rb'
require_relative 'Instances.rb'
require_relative 'Fragments.rb'
module MinimalCoverageProblem

  #This class is able to solve the minimal coverage problem. But it does not process results.
  class CoverageSolver
  
    #Creates a new instance of CoverageSolver
    def initialize(input_file_path)
      @path = input_file_path
    end
    
    #This method resolves all instances in input file given to the CoverageSolver in initialization, and returns an array of results.
    def run
      loader = nil
      results = []
      begin
        loader = InputLoader.new(File.new(@path))
        while(loader.hasNext?)
          inst = loader.nextInstance
          results[results.count] = resolve(inst)
        end
      ensure
        loader.close if loader != nil
      end
      results
    end
    
    private
    
    #This method gets a solution to the given instance in O(n) time. It uses a "limit" that says how long interval is already covered.
    #In the beginning, limit is set to 0. Algorithm then selects a fragment with "left" lesser or equal to the limit and maximal possible "right". Limit is then set to the "right" of selected fragment and algorithm repeats the selection.
    #Thus is ensured minimal number of used fragments as well as continuity of the covered interval.
    def resolve(instance)
      if(instance.fragments.count == 0)
        #return no solution result
        ResultInstance.new
      else
        #sort fragments by "left" attribute
        fragments = instance.fragments.sort
        result = ResultInstance.new
        #set initial limit to 0 and best fragment to nil
        limit = 0
        bestFragment = nil
        #for each fragment...
        fragments.each do |fragment|
          
          #if current fragments "left" is greater than current limit, then ...
          if(fragment.left > limit)
            #if best fragment is set ...
            #puts "bestFragment != nil: #{bestFragment != nil}"
            if(bestFragment != nil)
              #increase limit to best fragments right
              limit = bestFragment.right
              #add the best fragment to the result (its union with already used fragments will be a single interval)
              result.addFragment(bestFragment)

              #set best fragment back to nil
              bestFragment = nil
              #and if the current limit is greater or equal to required "m" value, then the solution is found (it is current result)
              if(limit >= instance.m)
                return result
              end
            #if best fragment is not set, current instance has no solution (current set of used fragments covers smaller section of X-axis than required and there is no fragment, that would extend it)
            else

              result.clear
              return result
            end
          end
         
          
          if(bestFragment != nil)
            #improve best fragment if it covers greater interval from the current limit
            bestFragment = fragment if(fragment.right > limit && fragment.right > bestFragment.right)
          else
            #set current fragment as best fragment only if its "left" is less or equal to current limit and "right" is greater than current limit
            bestFragment = fragment if(fragment.left <= limit && fragment.right > limit)
          end
         
        end
        if(bestFragment != nil)
          result.addFragment(bestFragment)
          if(bestFragment.right < instance.m)
            result.clear
          end
        else
          result.clear
        end
        result
      end
    end
  end
end

