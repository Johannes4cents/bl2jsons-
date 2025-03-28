module JSONsß
    class Sentīre
      attr_reader :sentence, :term_ray
  
      def initialize(sentence, terms)
        @sentence = sentence
        @term_ray = terms
      end
  
      def to_json_scroll
        { sentence => term_ray }
      end
    end
  
    class ScrollBuilder
      def self.from_array(array)
        array.map { |pair| Sentīre.new(pair[0], pair[1]).to_json_scroll }
      end
    end
  end
  