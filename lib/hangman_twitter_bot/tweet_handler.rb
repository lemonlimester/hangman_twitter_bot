# require './hangman_twitter_bot/twitter_api'
require_relative 'twitter_api'

class TweetHandler
  def initialize()
    @game_handlers = []
    @request_handlers = []
    @tweet_processor = TweetProcessor.new
    @stream = TwitterStream.new
    @session = TwitterSession.new
  end

  def add_game_handler(handler)
    @game_handlers.push(handler)
  end

  def remove_game_handler(handler)
    @game_handlers.delete(handler)
  end

  def add_new_game_request_handler(handler)
    @request_handlers.push(handler)
  end

  def remove_new_game_request_handler(handler)
    @request_handlers.delete(handler)
  end

  def start
    @stream.client.user do |object|
      puts object
      case object
      when Twitter::Tweet
        handle_tweet(object)
      when Twitter::DirectMessage
        handle_direct_message(object)
      when Twitter::Streaming::StallWarning
        warn "Falling behind!"
      end
    end
  end

  def display(game_handler_id, message)
    text = create_tweet(game_handler_id, message)
    @session.client.update(text)
  end

private

  def handle_tweet(tweet)
    return if is_tweet_from_game_handler?(tweet)

    letters = @tweet_processor.get_letters_from_tweet(tweet)

    @game_handlers.each do |game_handler|
      replies = game_handler.process_letters(letters)
      if (replies)
        replies.each { |reply| display(game_handler.id, reply) }
      end
    end
  end

  def is_tweet_from_game_handler?(tweet)
    result = false
    @game_handlers.each do |game_handler|
      if tweet.text.start_with?(game_handler.id)
        result = true
        break
      end
    end
    result
  end

  def create_tweet(game_handler_id, content)
    game_handler_id + " " + content
  end

  def reply_to_tweet(tweet, game_handler_id, reply)
    text = create_tweet(game_handler_id, reply)
    @session.client.update(text, { :in_reply_to_status => tweet })
  end

  def handle_direct_message(direct_message)
    word = @tweet_processor.get_word_from_direct_message(direct_message)

    @request_handlers.each do |handler|
      reply = handler.process_new_game_request(word)
      reply_to_direct_message(direct_message, reply) if reply
    end
  end

  def reply_to_direct_message(direct_message, reply)
    sender_id = direct_message.attrs[:sender_id] if direct_message.attrs.has_key?(:sender_id)
    recipient_id = direct_message.attrs[:recipient_id] if direct_message.attrs.has_key?(:recipient_id)

    if (sender_id && recipient_id && sender_id != recipient_id)
      @session.client.create_direct_message(sender_id, reply)
    end
  end
end
