require_relative 'color'
require_relative 'rectangle'
require_relative 'paint'
require_relative 'text_style'
require_relative 'layer'

class Node < Layer

    attr_reader :blend_mode,
        :absolute_bounding_box,
        :fills,
        :background_color,
        :visible,
        :style,
        :characters
    
    def initialize(raw)
        super(raw)
        @blend_mode = raw['blendMode']
        @absolute_bounding_box = Rectangle.new(raw['absoluteBoundingBox'])        
        @fills = raw['fills'].map { |f| Paint.new(f) }
        @background_color = Color.new(raw['backgroundColor']) if raw['backgroundColor'] != nil
        @visible = raw['visible']
        @children = raw['children'].map { |c| Node.new(c) } if raw['children'] != nil        
        @style = TextStyle.new(raw['style'], style_id('styles')) if raw['style'] != nil
        @characters = raw['characters']
    end

    def style_id(raw)
        if raw['text'] != nil
            return raw['text']
        else
            return nil
        end
    end
end