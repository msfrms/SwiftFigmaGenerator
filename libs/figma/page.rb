require_relative 'color'
require_relative 'node'
require_relative 'layer'

module Figma
    class Page < Layer

        attr_reader :background_color
        
        def initialize(raw)
            super(raw)        
            @children = raw['children'].map { |c| Node.new(c) }
            @background_color = Color.new(raw['backgroundColor'])
        end
    end
end