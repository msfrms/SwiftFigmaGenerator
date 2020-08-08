require_relative 'Layer'
require_relative 'page'

class Document < Layer

    attr_reader :children
    
    def initialize(raw)
        super(raw)

        if raw['children'] != nil then
            @children = raw['children'].map { |c| Page.new(c) }
        else
            @children = []
        end                
    end
end