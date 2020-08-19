require_relative 'color'
require_relative 'node'
require_relative 'layer'

module Figma
    class Page < Layer

        attr_reader :background_color
        
        def initialize(raw, parent)
            super(raw, parent)        
            @children = raw['children'].map { |c| Node.new(c, parent=self) }
            @background_color = Color.new(raw['backgroundColor'])
        end
    end
end