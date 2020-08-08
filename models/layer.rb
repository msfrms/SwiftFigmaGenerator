
class Layer

    attr_reader :id, :name, :type
    
    def initialize(raw)        
        @id = raw['id']
        @name = raw['name']
        @type = raw['type']
    end
end