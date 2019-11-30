module Models
  class Point
    attr_accessor :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end

    def translate(x, y)
      return self.clone.translate!(x, y)
    end

    def translate!(x, y)
      @x += x
      @y += y
      return self
    end

    def ==(point)
      return x == point.x && y == point.y
    end

    def to_s()
      return "#{super()} (#{x}, #{y})"
    end
  end
end
