class TweetProcessor
  def get_words(text)
    text.split.select { |word| !word.match(/\A([A-Za-z])+\z/).nil? }
  end

  def get_letters_from_tweet(tweet)
    words = get_words(tweet.text)
    letters = []
    words.each { |word| letters.concat(word.chars) }

    letters.uniq
  end

  def get_word_from_direct_message(direct_message)
    words = get_words(direct_message.text)
    if words.length == 1
      words[0]
    else
      nil
    end
  end
end
