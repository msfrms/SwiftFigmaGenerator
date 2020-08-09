require_relative 'page'
require_relative 'layer'

module Figma
    class Document < Layer
        def initialize(raw)
            super(raw)
    
            if raw['children'] != nil then
                @children = raw['children'].map { |c| Page.new(c) }
            else
                @children = []
            end                
        end        
    end
end