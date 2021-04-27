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

    it 'encrypts using todays date' do
      enigma = Enigma.new

      allow(enigma).to receive(:offsets) do
        "240421"
      end

      expected = enigma.encrypt("Hello, World!?!?", "02715", enigma.offsets)
      expect(expected).to eq(encryption: "qgfax,ulxtft!?!?",
                             key: "02715",
                             date: "240421")
    end

    it 'enctypts using random key and todays date' do
      enigma = Enigma.new

      allow(enigma).to receive(:offsets) do
        "240421"
      end

      allow(enigma). to receive(:set_keys) do
        "30298"
      end

      expected = enigma.encrypt("Hello, World!?!?", enigma.set_keys, enigma.offsets)

      expect(expected).to eq(encryption: "rircy,fnyvrv!?!?",
                             key: "30298",
                             date: "240421")
    end
  end

  describe '#decrypt' do
    it 'decrypts the message given' do
      enigma = Enigma.new

      expected = enigma.decrypt("keder ohulw", "02715", "040895")
      expected2 = enigma.decrypt("keder ohulw!", "02715", "040895")

      expect(expected).to eq(decryption: "hello world",
                             key: "02715",
                             date: "040895")
      expect(expected2).to eq(decryption: "hello world!",
                             key: "02715",
                             date: "040895")
    end

    it 'decrypts using todays date' do
      enigma = Enigma.new

      allow(enigma).to receive(:offsets) do
        "240421"
      end

      expected = enigma.decrypt("qgfax,ulxtft!?!?", "02715", enigma.offsets)

      expect(expected).to eq(decryption: "hello, world!?!?",
                             key: "02715",
                             date: "240421")
    end
  end

  describe "#check_special_char" do
    it "checks for any characters that arent ' ' or a..z" do
      enigma = Enigma.new

      expect(enigma.check_special_char('?')).to eq(true)
      expect(enigma.check_special_char("a")).to eq(false)
    end
  end
end