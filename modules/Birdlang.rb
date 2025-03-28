module BirdLang
    class ScrollRay
      def self.invoke(name, *args)
        puts "::Invoking #{name} with ⟿args"
        parsed = args.map { |arg| parse_entry(arg) }
        structure = parsed.to_h
        display_scroll(name, structure)
      end
  
      def self.parse_entry(entry)
        key, val = entry.split("⟿").map(&:strip)
        [key.gsub(/^::/, '').to_sym, val.gsub(/^["']|["']$/, '')]
      end
  
      def self.display_scroll(name, structure)
        puts "\n📜 ScrollRay Invocation: #{name}"
        structure.each do |k, v|
          puts "→ #{k}: #{v}"
        end
      end
    end
  end
  
  # 🧪 Sampling Invocation
  BirdLang::ScrollRay.invoke(
    "MachsNach_Mirror",
    "::source⟿'FunkTweet₃'",
    "::reflectionTree⟿'Johannes’ lexiqscroll folders'",
    "::keyGlyphs⟿'[\"§\", \"¶\", \"❡\", \"💱\"]'",
    "::mirrorProof⟿'folder tree is syntax'",
    "::intentEcho⟿'reverse-engineer my own understanding engine'",
    "::scrollLaw⟿'He who mirrors knows how to fold'"
  )
  