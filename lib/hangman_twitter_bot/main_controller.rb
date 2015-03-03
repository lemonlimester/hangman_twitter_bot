class MainController
  def initialize
    @game_controller = nil
    @tweet_handler = TweetHandler.new
    @tweet_handler.add_new_game_request_handler(self)
  end

  def start
    @tweet_handler.start
  end

  def process_new_game_request(word)
    if @game_controller && !@game_controller.is_game_ended?
      "Can't start a new game. There is an ongoing game."
    elsif word.nil? || word.empty?
      "The word is invalid."
    else
      @game_controller = GameController.new(word, @tweet_handler)
    end
  end
end
