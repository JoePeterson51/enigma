require 'simplecov'
SimpleCov.start
require 'date'
require './lib/enigma'

RSpec.describe do
  describe '#initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).to be_a(Enigma)
    end

    it 'has attributes' do
      enigma = Enigma.new

      expect(enigma.alphabet).to eq([
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
        "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
        "w", "x", "y", "z", " "])
    end
  end

  describe '#set_keys' do
    it 'creates the keys' do
      enigma = Enigma.new

      enigma.set_keys
      expect(enigma.keys).to be_a(String)
      expect(enigma.keys.length).to eq(5)
    end
  end

  describe '#set_offsets' do
    it 'creates offsets' do
      enigma = Enigma.new

      expect(enigma.offsets).to be_a(String)
      expect(enigma.offsets.length).to eq(6)
    end
  end

  describe '#shifts' do
    it 'creates the shift positions' do
      enigma = Enigma.new

      expect(enigma.shifts("040895", '02715')).to eq({:a=>3, :b=>27, :c=>73, :d=>20})
    end
  end

  describe '#encrypt' do
    it 'encrypts the message given' do
      enigma = Enigma.new

      expected = enigma.encrypt("hello world", "02715", "040895")
      expected2 = enigma.encrypt("HELLO WORLD", "02715", "040895")
      expected3 = enigma.encrypt("hello world!", "02715", "040895")

      expect(expected).to eq(encryption: "keder ohulw",
                             key: "02715",
                             date: "040895")
      expect(expected2).to eq(encryption: "keder ohulw",
                             key: "02715",
                             date: "040895")
      expect(expected3).to eq(encryption: "keder ohulw!",
                             key: "02715",
                             date: "040895")
    end
  end

  describe '#code_cracker' do
    it 'can crack a code without the key' do
      enigma = Enigma.new

      expected = enigma.encrypt("end", "02715", "040895")

      expect(expected).to eq(:date=> "040895",
                              :encryption=> "hnw",
                              :key=> "02715")
        # e shifts 3
        # n shifts 27
        # d shifts 73
        # 1, 0, 2, 5 are the offsets
        # 2, 27, 71, 15 are the keys but we don't know these

        # 1) square the date to get the offsets
        # 2) pull off the last 4 digits (1, 0, 2, 5 )
        # 3) find the difference in position e -> h = 2
        # 4) subtract the offset we know from the difference
        # 5) a: key = 2

      expect(enigma.code_cracker("hnw", "040895")).to eq()
    end
  end
end