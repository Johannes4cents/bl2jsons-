class FunkTweet
    def initialize(name)
      @name = name
      @payload = {}
    end
  
    def method_missing(sym, val)
      @payload[sym] = val
    end
  
    def cast
      puts "🔮 FunkTweet #{@name}: #{@payload.inspect}"
    end
  end
  
  tweet = FunkTweet.new("truth-routing-symbol")
  tweet.anchor("💱")
  tweet.fraction("¼")
  tweet.scrollLaw("§")
  tweet.cast
  