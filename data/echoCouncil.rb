echoCouncil = [
  GPT_SeriReflect.new,
  GPT_DialogueObserver.new,
  GPT_TrustAnchor.new("Yasminique"),
  SeriAce.new(:symbolic)
]

loop do
  sleep(random_delay)
  echoCouncil.each(&:whisper)
end
