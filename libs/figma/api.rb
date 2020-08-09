require 'json'
require 'http'
require_relative 'file'

module Figma
    
    class Icon

        attr_reader :name, :url
    
        def initialize(name, url)
            @name = name
            @url = url
        end
    
    end
    
    class API
    
        def initialize(key)
            @key = key
        end
    
        def client
            HTTP.headers('X-Figma-Token' => '55196-8229ee5c-03d7-4382-a7b9-6c3b42d64b00')
        end
        
        def images(nodes)
            ids = nodes.map(&:id)
            names = nodes.map(&:name)
            json = JSON.parse(
                client
                    .get("https://api.figma.com/v1/images/#{@key}", :params => {
                        :ids => ids.join(','),
                        :format => 'pdf'
                    })
                    .body
                    .to_s
            )
            hash = nodes.map { |node| [node.id, node.name] }.to_h        
            json['images'].map { |key, url| Icon.new(hash[key], url) }
        end
    
        def files
            json = client.get("https://api.figma.com/v1/files/#{@key}")
            File.new(JSON.parse(json))
        end
    end
end