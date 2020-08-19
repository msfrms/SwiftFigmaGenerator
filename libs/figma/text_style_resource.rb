require_relative 'api'
require 'erb'

module Figma
    class TextStyleResource

        SwiftStyle = Struct.new(:name, :style, :color, :description)

        def initialize(key)
            @key = key
        end

        def export_text_styles
            file = API.new(@key).files            
            texts = file.document
                .flatten
                .filter { |node|
                    node.type == 'TEXT' and node.fills.filter { |fill| fill.type == "SOLID" }.size > 0
                }
                .filter { |node|
                    is_exist_style = file.styles.key?(node.style.id)
                    if not is_exist_style then
                        puts "WARNING: style not found in node(#{node.name})! (path to node: #{node.recursive_path_name})"
                    end
                    is_exist_style
                }
                .map { |text| SwiftStyle.new(
                    name="text_#{file.styles[text.style.id].name}", 
                    style=text.style, 
                    color=text.fills.last.color,
                    description=file.styles[text.style.id].description) 
                }
                .uniq(&:name)
            swift_template = ERB.new(::File.read("libs/figma/templates/text_styles_swift.erb"))
            ::File.write('TextStyles.swift', swift_template.result_with_hash(texts: texts))
        end
    end    
end