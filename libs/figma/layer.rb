require_relative 'node'

module Figma
    class Layer

        attr_reader :id, :name, :type, :children, :parent
        
        def initialize(raw, parent)        
            @id = raw['id']
            @name = raw['name']
            @type = raw['type']
            @children = []
            @parent = parent
        end
    
        def filter(name)
            flatten.filter { |node| node.name.downcase.include?(name.downcase) }        
        end
    
        def flatten
            [self] + children.map(&:flatten).flatten
        end

        def recursive_path_name
            if not parent then
                return "file"
            else
                return "#{parent.recursive_path_name} -> #{name}" 
            end           
        end

        def is_node?
            self.class == Node
        end
    end
end