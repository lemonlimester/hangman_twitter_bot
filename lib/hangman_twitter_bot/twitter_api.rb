require "twitter"
require_relative "../../secrets"

class TwitterSession
  attr_accessor :client
  def initialize
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = TWITTER_CONSUMER_KEY
      config.consumer_secret = TWITTER_CONSUMER_SECRET
      config.access_token = TWITTER_ACCESS_TOKEN
      config.access_token_secret = TWITTER_ACCESS_TOKEN_SECRET
    end
  end
end

class TwitterStream
  attr_accessor :client
  def initialize
     @client ||= Twitter::Streaming::Client.new do |config|
      config.consumer_key = TWITTER_CONSUMER_KEY
      config.consumer_secret = TWITTER_CONSUMER_SECRET
      config.access_token = TWITTER_ACCESS_TOKEN
      config.access_token_secret = TWITTER_ACCESS_TOKEN_SECRET
    end
  end
end
