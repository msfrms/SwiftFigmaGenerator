require_relative 'api'
require_relative 'file'
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

        Dir.mkdir("#{@folder}/#{@name}.imageset") unless ::File.directory?("#{@folder}/#{@name}.imageset")
        ::File.write("#{@folder}/#{@name}.imageset/Contents.json", contents.to_json)
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

    def initialize(file_key, folder)
        @api = API.new(file_key)
        @folder = folder
    end

    def export_icons
        nodes = @api.files.document.filter('_icon')        
        Namespace.new(@folder).create
        @api.images(nodes).each do |icon|
            pdf = HTTP.get(icon.url).body            
            name = icon.name.gsub("/", "")
            Imageset.new(name, @folder).create            
            path = "#{@folder}/#{name}.imageset/#{name}.pdf"            
            ::File.write(path, pdf)
        end
    end
  end    
end