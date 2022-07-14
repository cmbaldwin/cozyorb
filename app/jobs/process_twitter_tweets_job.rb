class ProcessTwitterTweetsJob < ApplicationJob
  queue_as :default

  def save_tweet(tweet)
    new_tweet = Tweet.new(id: id)
    tweet.each do |key, val|
      new_tweet[key] = val if new_tweet.respond_to?(key)
      new_tweet[:text] = val if key == 'full_text'
    end
    logger.debug "Saving #{i} of #{tweets.count}"
    new_tweet.save
  end

  def perform(tweets)
    tweets.each_with_index do |twhash, i|
      tweet = twhash['tweet']
      id = tweet['id_str'].to_i
      next if Tweet.exists?(id)

      save_tweet(tweet)
    end
  end
end
