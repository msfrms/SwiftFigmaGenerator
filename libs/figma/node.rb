require_relative 'color'
require_relative 'rectangle'
require_relative 'paint'
require_relative 'text_style'
require_relative 'layer'

module Figma
    class Node < Layer

        attr_reader :blend_mode,
            :absolute_bounding_box,
            :fills,
            :background_color,
            :visible,
            :style,
            :characters
        
        def initialize(raw, parent)
            super(raw, parent)
            @blend_mode = raw['blendMode']
            @absolute_bounding_box = Rectangle.new(raw['absoluteBoundingBox'])        
            @fills = raw['fills'].map { |f| Paint.new(f, style_id(raw['styles'], key='fill'), parent=self) } if raw['fills'] != nil
            @background_color = Color.new(raw['backgroundColor']) if raw['backgroundColor'] != nil
            @visible = raw['visible']
            @children = raw['children'].map { |c| Node.new(c, parent=self) } if raw['children'] != nil
            @style = TextStyle.new(raw['style'], style_id(raw['styles'], key='text')) if raw['style'] != nil
            @characters = raw['characters']
        end

        def style_id(raw, key)            
            if raw != nil and raw[key] != nil
                return raw[key]
            else
                return nil
            end
        end

        def is_text?
            type == 'TEXT'
        end
    end
end