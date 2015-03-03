class GameController
  attr_reader :id, :answer

  def initialize(word, handler)
    @answer = word
    @id = DateTime.now.strftime('%Y%m%d%H%M%S')
    @word_controller = WordController.new(word)
    @hangman_creator = HangmanCreator.new

    @handler = handler

    @handler.add_game_handler(self)
    @handler.display(id, game_state)
  end

  def process_letters(letters)
    return if is_game_ended? || letters.empty?

    letters.each do |letter|
      process_a_letter(letter)
      break if is_game_ended?
    end

    responses = [game_state]
    if is_game_ended?
      responses.push(game_result)
      @handler.remove_game_handler(self)
    end

    responses
  end

  def is_game_ended?
    @word_controller.complete? || @hangman_creator.complete?
  end

  private

  def process_a_letter(letter)
    if !@word_controller.process_a_letter(letter)
      @hangman_creator.progress
    end
  end

  def game_state
    state = @word_controller.word
    if !@hangman_creator.hangman.empty?
      state = state + "\n\n" + @hangman_creator.hangman
    end

    state
  end

  def game_result
    if @word_controller.complete?
      ":-)"
    else
      ":-(  [#{@answer}]"
    end
  end
end
