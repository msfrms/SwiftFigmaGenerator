require_relative 'document'

module Figma
    class FileStyle
        attr_reader :key, :name, :style_type, :description
    
        def initialize(raw)            
            @key = raw['key']
            @name = raw['name']
            @style_type = raw['styleType']
            @description = raw['description']
        end
    end
    
    class File
    
        attr_reader :document, :name, :styles
    
        def initialize(raw)
            @document = Document.new(raw['document'], parent=nil)
            @name = raw['name']
            @styles = raw['styles'].map { |k, v| [k, FileStyle.new(v)] }.to_h
        end    
    end
end