require 'json'
require 'excon'
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
    
        def headers
            {
                'X-FIGMA-TOKEN' => '147057-e0e3fc9c-993c-4ccb-a61d-df3d54c3be9e'
            }
        end
        
        def images(nodes)
            ids = nodes.map(&:id)
            if not ids.empty? then
                response = Excon
                .get("https://api.figma.com/v1/images/#{@key}", 
                    :query => {
                        :ids => ids.join(','),
                        :format => 'pdf'
                    }, 
                    :headers => headers
                )
                .body
                .to_s

                json = JSON.parse(response)            
                hash = nodes.map { |node| [node.id, node.name] }.to_h
                return json['images'].map { |key, url| Icon.new(hash[key], url) }
            else
                return []
            end
        end
    
        def files
            json = Excon.get("https://api.figma.com/v1/files/#{@key}", :headers => headers).body            
            File.new(JSON.parse(json))
        end
    end
end