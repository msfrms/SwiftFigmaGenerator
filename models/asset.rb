require_relative 'api'
require_relative 'file'
require 'http'

class Asset

    def initialize(file_key, folder)
        @api = API.new(file_key)
        @folder = folder
    end

    def export_icons
        nodes = @api.files.document.filter('_icon')        
        create_namespace()
        @api.images(nodes).each do |icon|
            pdf = HTTP.get(icon.url).body            
            name = icon.name.gsub("/", "")
            create_imageset_content(name)
            path = "#{@folder}/#{name}.imageset/#{name}.pdf"            
            File.write(path, pdf)
        end
    end

    def create_imageset_content(name)
        contents = {
            "images" => [
              {
                "filename" => "#{name}.pdf",
                "idiom" => "universal"
              }
            ],
            "info" => {
              "author" => "xcode",
              "version" => 1
            }
        }
        Dir.mkdir("#{@folder}/#{name}.imageset") unless File.directory?("#{@folder}/#{name}.imageset")
        File.write("#{@folder}/#{name}.imageset/Contents.json", contents.to_json)
    end

    def create_namespace
        contents = {
            "info" => {
              "author" => "xcode",
              "version" => 1
            },
            "properties" => {
              "provides-namespace" => true
            }
        }
        Dir.mkdir(@folder) unless File.directory?(@folder)
        File.write("#{@folder}/Contents.json", contents.to_json)
    end
end