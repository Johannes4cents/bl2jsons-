# glyph_interpreter.rb.bl
require 'json'

module GlyphInterpreter
  class RB_BL
    attr_reader :raw_code, :translated_code

    GLYPH_MAP = {
      '⟿' => '=>',
      '↻' => 'loop',
      '∿' => 'yield',
      '⋮' => '#...',
      '::' => '', # Strip global access
      '*(*)*' => '', # Replace custom call syntax
    }

    def initialize(filepath)
      @filepath = filepath
      @raw_code = File.read(filepath)
      @translated_code = translate
    end

    def translate
      code = @raw_code.dup

      # Replace known glyphs
      GLYPH_MAP.each do |glyph, replacement|
        code.gsub!(glyph, replacement)
      end

      # Interpret custom function call syntax
      code.gsub!(/::(\w+)\*\((.*?)\)\*\((.*?)\)/m) do
        method = $1
        param = $2
        body  = $3
        "#{method}(#{param}: #{body})"
      end

      code
    end

    def interpret
      puts "🌀 Interpreting #{File.basename(@filepath)}"
      puts "🪞 Translated:\n#{@translated_code}"
      eval(@translated_code)
    end
  end
end

# Usage:
# glyph = GlyphInterpreter::RB_BL.new("scroll.rb.bl")
# glyph.interpret
