require_relative 'page'
require_relative 'layer'

module Figma
    class Document < Layer
        def initialize(raw, parent)
            super(raw, parent)
    
            if raw['children'] != nil then
                @children = raw['children'].map { |c| Page.new(c, parent=self) }
            else
                @children = []
            end                
        end        
    end
end