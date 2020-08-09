require_relative 'color'

module Figma
    class Paint

        attr_reader :blend_mode, :type, :color
    
        def initialize(raw)        
            @blend_mode = raw['blendMode']
            @type = raw['type']
            @color = Color.new(raw['color'])
        end
    end
end