

module Squares
  
  #Bod v rovině
  class Point
    #Vytvoří novou instanci bodu
    def initialize(x,y)
      @x = x
      @y = y
    end
    
    #Vypise bod
    def to_s
      "[#{@x}, #{@y}]"
    end
    
    #X-souřadnice bodu
    attr_reader :x
    
    #Y-souřadnice bodu
    attr_reader :y
  end
  
  #Čtverec, jehož instancí hledáme obsah sjednocení
  class Square
  
    #Vytvoří novou instanci čtverce se zadanými parametry
    def initialize(x, y, a)
      @x = x
      @y = y
      @a = a
    end
    
    #X-souřadnice středu čtverce
    attr_reader :x
    #Y-souřadnice středu čtverce
    attr_reader :y
    #Délka hrany čtverce
    attr_reader :a
    
    #Vrátí obsah čtverce
    def area
      @a*@a
    end
    
    #Vrátí seznam bodů, příslušejících jednotlivým rohům čtverce {a,b,c,d}.
    def corners
      res=[]
      res[0] = Point.new(@x - @a/2, @y - @a/2)
      res[1] = Point.new(@x + @a/2, @y - @a/2)
      res[2] = Point.new(@x - @a/2, @y + @a/2)
      res[3] = Point.new(@x + @a/2, @y + @a/2)
      res
    end
    
    #Vrátí true, pokud bod, zadaný jako argument, je uvnitř tohoto čtverce.
    def contains_point?(point)
      (point.x >= @x - @a/2 && point.x <= @x + a/2) && (point.y >= @y - @a/2 && point.y <= @y + @a/2)
    end
    
    #Metoda, která spočítá obsah pruniku s jiným čtvercem
    def intersection(other_square)
      larger = self
      smaller = other_square
      if(self.a < other_square.a)
        larger = other_square
        smaller = self
      end
      
      lcorners = larger.corners
      scorners = smaller.corners
      
      points_inside = []
      points_inside_nr = 0
      4.times do |index|
        if(larger.contains_point?(scorners[index]))
          points_inside_nr += 1
          points_inside[index] = 1
        else
          points_inside[index] = 0
        end
      end
      
      a = 0
      b = 0
      c = 0
      points = []
      if(points_inside_nr == 0)
        0
      elsif(points_inside_nr == 1)
        4.times do |index|
          if(points_inside[index] == 1)
            a = scorners[index]
            b = lcorners[3 - index]
            c = (a.x - b.x).abs * (a.y - b.y).abs 
            break
          end
        end
        c
      elsif(points_inside_nr == 2)
        4.times do |index|
          if(points_inside[index] == 1)
            points[a] = index
            a += 1
          end
        end
        a = scorners[points[0]]
        b = scorners[points[1]]
        c = lcorners[3 - points[0]]
        (a.x - c.x).abs * (a.y - c.y).abs - (b.x - c.x).abs * (b.y - c.y).abs
      elsif(points_inside_nr == 4)
        smaller.area
      else
        p "Error. It is impossible for a square to contain only 3 corners of another square."
      end
    end
  end
  
  
end
