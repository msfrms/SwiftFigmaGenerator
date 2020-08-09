require_relative 'document'

module Figma
    class Style
        attr_reader :id, :key, :name, :style_type, :description
    
        def initialize(raw, id)
            @id = id
            @key = raw['key']
            @name = raw['name']
            @style_type = raw['styleType']
            @description = raw['description']
        end
    end
    
    class File
    
        attr_reader :document, :name, :styles
    
        def initialize(raw)
            @document = Document.new(raw['document'])
            @name = raw['name']
            @styles = raw['styles'].map { |k, v| Style.new(v, k) }
        end    
    end
end