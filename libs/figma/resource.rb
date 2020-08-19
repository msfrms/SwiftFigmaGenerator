require_relative 'api'
require_relative 'asset'
require_relative 'style'

module Figma
    class Resource
        
        def initialize(key)
            @key = key
        end

        def export_icons(namespace)
            Asset.new(@key, namespace).export_icons
        end

        def export_text_styles
            TextStyleResource.new(@key).export_text_styles
        end

        def export_colors
        end        
    end
end