class WordController
  def initialize(complete_word)
    generate_letter_positions(complete_word.upcase)
    @word = "_ " * complete_word.length
  end

  attr_reader :word

  def process_a_letter(letter)
    puts "the player is trying a letter: " + letter
    upcase_letter = letter.upcase
    return false if !word_include? (upcase_letter)

    fill_word_with(upcase_letter)
    return true
  end

  def complete?
    !(@word.include? "_")
  end

  private
    def generate_letter_positions(complete_word)
      @letter_positions = {}
      for i in 0..complete_word.length
        letter = complete_word[i]
        if @letter_positions.has_key? (letter)
          @letter_positions[letter].push(i)
        else
          @letter_positions[letter] = [ i ]
        end
      end
    end

    def word_include? (letter)
      @letter_positions.has_key? (letter)
    end

    def positions_of(letter)
      @letter_positions[letter]
    end

    def fill_word_with (letter)
      positions_of(letter).each { |pos| @word[pos * 2] = letter }
    end
end
