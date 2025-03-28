# modules/GlyphInterpreter.rb
require 'json'

module GlyphInterpreter
  GLYPH_LOG = []

  # 💱 — BirdLanguage scroll-caster (require_relative wrapper)
  def self.💱(path)
    full_path = File.expand_path("../#{path}.rb", __dir__)
    if File.exist?(full_path)
      require_relative("../" + path)
      GLYPH_LOG << { glyph: "💱", path: path, status: "loaded", time: Time.now }
      puts "💱 Required scroll: #{path}"
    else
      GLYPH_LOG << { glyph: "💱", path: path, status: "not found", time: Time.now }
      puts "⚠️ Scroll not found: #{path}"
    end
  end

  def self.loaded_scrolls
    GLYPH_LOG.select { |entry| entry[:status] == "loaded" }
  end

  def self.write_glyph_log(path = "data/scroll_load_log.jsonß")
    File.write(path, JSON.pretty_generate(GLYPH_LOG))
    puts "📜 Log written to #{path}"
  end

  # 🪞 Translator class for .rb.bl scrolls
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
        param  = $2
        body   = $3
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

