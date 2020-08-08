class Rectangle

    attr_reader :x, :y, :width, :height
    
    def initialize(raw)
        @x = raw['x']
        @y = raw['y']
        @width = raw['width']
        @height = raw['height']
    end
end