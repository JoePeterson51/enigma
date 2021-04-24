class Enigma
  attr_reader :alphabet, :keys, :offsets
  def initialize
    @alphabet = ("a".."z").to_a << " "
    @keys = keys
    @offsets = offsets
  end

  def set_keys
    set_keys = rand 0..99999
    @keys = set_keys.to_s.rjust(5, "0")
  end

  def offsets
    Time.now.strftime('%d%m%y')
  end

  def shifts(date, key)
    shifts = {}
    date = date.to_i.abs2
    shifts[:a] = date.digits[3] += key.to_s[0..1].to_i
    shifts[:b] = date.digits[2] += key.to_s[1..2].to_i
    shifts[:c] = date.digits[1] += key.to_s[2..3].to_i
    shifts[:d] = date.digits[0] += key.to_s[3..4].to_i
    shifts
  end

  def check_special_char(letter)
    special_char = ["!", ".", "?", ",", "'", " "]
    special_char.include?(letter)
  end

  def encrypt(message, key, date)
    encrypted = []
    output = {:date => date, :encryption => ' ', :key => key}
    shift = shifts(date, key).values
    message.downcase.split('').each do |letter|
      if check_special_char(letter)
        encrypted << letter
        shift = shift.rotate(1)
        next
      end
      position = alphabet.index(letter)
      new_alpha = alphabet.rotate(shift[0])
      encrypted << new_alpha[position]
      shift = shift.rotate(1)
    end
    output[:encryption] = encrypted.join
    output
  end

  def decrypt(decrypted, key, date)
    encrypted = []
    output = {:date => date, :encryption => ' ', :key => key}
    shift = shifts(date, key).values
    decrypted.downcase.split('').each do |letter|
      if check_special_char(letter)
        encrypted << letter
        shift = shift.rotate(1)
        next
      end
      new_alpha = alphabet.rotate(shift[0])
      position = new_alpha.index(letter)
      encrypted << alphabet[position]
      shift = shift.rotate(1)
    end
    output[:encryption] = encrypted.join
    output
  end

  def code_cracker(encrypted, date)
    offset = date.to_i.abs2
    encrypted_split = encrypted.split('')
    end_positions = [4, 13, 3]
    new_pos_1 = alphabet.index(encrypted_split[-3])
    new_pos_2 = alphabet.index(encrypted_split[-2])
    new_pos_3 = alphabet.index(encrypted_split[-1])
  end
end