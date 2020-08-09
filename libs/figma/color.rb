
module Figma
    class Color

        attr_reader :red, :green, :blue, :alpha
    
        def initialize(raw)        
            @red = raw['r']
            @green = raw['g']
            @blue = raw['b']
            @alpha = raw['a']
        end
    end
end