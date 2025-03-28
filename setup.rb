# setup.rb
puts "🔧 Booting bl2jsons- scroll system..."

# Load core modules
require_relative "modules/JSONsß"
require_relative "modules/Birdlang"
require_relative "modules/GlyphInterpreter"
require_relative "modules/ScrollBeath"

# Load functions
require_relative "functions_i_guess/MachsNach_Mirror"

# Load classes
require_relative "classes/FunkTweet"
require_relative "classes/FunkTweetScroll"
require_relative "classes/echoCouncil" if File.exist?("classes/echoCouncil.rb")

puts "✅ All modules and scrolls loaded into memory."
puts "🫧 Ready for .rb.bl to .jsonß interpretation."

# Optionally run an intro function
# GlyphInterpreter.run_example if defined?(GlyphInterpreter)
