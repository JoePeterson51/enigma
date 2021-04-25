require './lib/enigma'

enigma = Enigma.new
enigma.set_keys
keys = enigma.keys
date = enigma.offsets

puts "Created #{ARGV[1]} with the key #{keys} and date #{date}"
message = enigma.encrypt(File.read(ARGV[0]), keys, date)
File.write(ARGV[1], message[:encryption])





