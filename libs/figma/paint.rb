require_relative 'color'

module Figma
    class Paint

        attr_reader :id, :blend_mode, :type, :color
    
        def initialize(raw, id)
            @id = id
            @blend_mode = raw['blendMode']
            @type = raw['type']
            @color = Color.new(raw['color']) if raw['color'] != nil
        end
    end
end