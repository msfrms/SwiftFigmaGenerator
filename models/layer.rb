
class Layer

    attr_reader :id, :name, :type, :children
    
    def initialize(raw)        
        @id = raw['id']
        @name = raw['name']
        @type = raw['type']
        @children = []
    end

    def filter(name)
        flatten.filter { |node| node.name.include?(name) }        
    end

    def flatten
        [self] + children.map(&:flatten).flatten
    end

end