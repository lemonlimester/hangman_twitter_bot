class TweetProcessor
  def get_letters_from_tweet(tweet)
    filter_tweet(tweet.text).chars.compact.uniq
  end

  def get_word_from_direct_message(tweet)
    filter_tweet(tweet.text)
  end

private

  def filter_tweet(text)
    text.gsub(/\B[@#]\S+\b/, '').gsub(/[^A-Za-z]/i, '').downcase
  end
end
