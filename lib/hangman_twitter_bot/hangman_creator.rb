class HangmanCreator

  def initialize()
    @parts = [
      "",
      "|\n|\n|\n|",
      "|----\n|\n|\n|",
      "|----|\n|\n|\n|",
      "|----|\n|     O\n|\n|",
      "|----|\n|     O\n|      |\n|",
      "|----|\n|     O\n|    / |\n|",
      "|----|\n|     O\n|    / | \\\n|",
      "|----|\n|     O\n|    / | \\\n|     / ",
      "|----|\n|     O\n|    / | \\\n|     / \\",
    ]
    @current_step = 0
    @last_step = @parts.length - 1
  end

  def progress
    return false if @current_step >= @last_step

    @current_step += 1
    return true
  end

  def complete?
    @current_step >= @last_step
  end

  def hangman
    @parts[@current_step]
  end
end
