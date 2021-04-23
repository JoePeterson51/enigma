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
end