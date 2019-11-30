module Models
  class Size
    attr_accessor :width, :height

    def initialize(width, height)
      @width = width
      @height = height
    end
  end
end
