require_relative 'color'

module Figma
    class Paint

        attr_reader :id, :blend_mode, :type, :color, :parent
    
        def initialize(raw, id, parent)
            @id = id
            @parent = parent
            @blend_mode = raw['blendMode']
            @type = raw['type']
            @color = Color.new(raw['color']) if raw['color'] != nil
        end

        def is_solid?
            type == 'SOLID'
        end
    end
end