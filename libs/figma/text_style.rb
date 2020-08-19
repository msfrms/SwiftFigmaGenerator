
module Figma
    class TextStyle
        class Decoration
            STRIKETHROUGH = "STRIKETHROUGH"
            UNDERLINE = "UNDERLINE"
        end
    
        attr_reader :id, 
            :font_family,
            :font_post_script_name,
            :font_weight,
            :font_size,
            :text_decoration, # STRIKETHROUGH, UNDERLINE, default: none
            :paragraph_spacing,
            :paragraph_indent,
            :italic,
            :letter_spacing,
            :line_height_px,
            :alignment
    
        def initialize(raw, id)
            @id = id
            @font_family = raw['fontFamily']
            @font_post_script_name = raw['fontPostScriptName']
            @font_weight = raw['fontWeight']
            @font_size = raw['fontSize']
            @text_decoration = raw['textDecoration']
            @paragraph_spacing = raw['paragraphSpacing']
            @paragraph_indent = raw['paragraphIndent']
            @italic = raw['italic']
            @letter_spacing = raw['letterSpacing']
            @line_height_px = raw['lineHeightPx']
            @alignment = raw['textAlignHorizontal']
        end
    end
end