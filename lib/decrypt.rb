require './lib/enigma'

enigma = Enigma.new

puts "Created #{ARGV[1]} with the key #{ARGV[2]} and date #{ARGV[3]}"
message = enigma.decrypt(File.read(ARGV[0]), ARGV[2].to_s, ARGV[3].to_s)
File.new(ARGV[1], 'w').print(message[:encryption])
