require_relative 'api'
require_relative 'file'
require_relative 'color'
require 'http'

module Figma

  class Asset

    class Imageset

      def initialize(name, folder)
        @name = name
        @folder = folder
      end

      def create
        contents = {
          "images" => [
            {
              "filename" => "#{@name}.pdf",
              "idiom" => "universal"
            }
          ],
          "info" => {
            "author" => "xcode",
            "version" => 1
          }
        }
        imageset_path = "#{@folder}/#{@name}.imageset"
        Dir.mkdir(imageset_path) unless ::File.directory?(imageset_path)
        ::File.write("#{imageset_path}/Contents.json", contents.to_json)
      end
    end

    class Colorset

      attr_reader :name, :color

      def initialize(name, color)
        @name = name
        @color = color
      end

      def create
        contents = {
          "colors" => [
            {
              "color" => {
                "color-space" => "srgb",
                "components" => {
                  "alpha" => "#{@color.alpha}",
                  "blue" => "#{@color.blue}",
                  "green" => "#{@color.green}",
                  "red" => "#{@color.red}"
                }
              },
              "idiom" => "universal"
            }
          ],
          "info" => {
            "author" => "xcode",
            "version" => 1
          }
        }

        colorset_path = "#{@name}.colorset"
        Dir.mkdir(colorset_path) unless ::File.directory?(colorset_path)
        ::File.write("#{colorset_path}/Contents.json", contents.to_json)
      end

    end

    class Namespace

      def initialize(name)
        @name = name
      end

      def create
        contents = {
          "info" => {
            "author" => "xcode",
            "version" => 1
          },
          "properties" => {
            "provides-namespace" => true
          }
        }
        Dir.mkdir(@name) unless ::File.directory?(@name)
        ::File.write("#{@name}/Contents.json", contents.to_json)
      end

    end

    def initialize(file_key)
        @api = API.new(file_key)        
    end

    def export_icons(folder)
        nodes = @api.files.document.filter('_icon')        
        Namespace.new(folder).create
        @api.images(nodes).each do |icon|
            pdf = HTTP.get(icon.url).body            
            name = icon.name.gsub("/", "")
            Imageset.new(name, folder).create            
            path = "#{folder}/#{name}.imageset/#{name}.pdf"            
            ::File.write(path, pdf)
        end
    end

    def export_colors
      file = @api.files
      colors = file.document
                .flatten                
                .filter(&:is_node?)
                .map { |node| 
                  puts "name: #{node.name}"
                  node
                }
                .map { |node| node.fills }
                .flatten
                .filter(&:is_solid?)                
                .filter { |paint|
                    style = file.styles[paint.id]
                    if not style then
                        puts "WARNING: color not found in table color styles!!!(nearest node: #{paint.parent.name})! (path to nearest node: #{paint.parent.recursive_path_name})"
                    end
                    style != nil and style.is_fill?                    
                }
                .map { |paint| Colorset.new(name="#{file.styles[paint.id].name}", color=paint.color) }
                .uniq { |paint| paint.color.id }

      colors.each do |color|
        puts color.name
        color.create
      end       
    end
  end    
end