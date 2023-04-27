# frozen_string_literal: true

# Scrapbook Helper
module ScrapbookHelper
  def owned_tweet(post, tweet)
    return 'bg-white' unless tweet

    owned?(post) ? 'bg-sky-100' : 'bg-white'
  end

  def owned?(post)
    !(post.retweeted || post.is_quote_status || post.truncated || post.in_reply_to_screen_name)
  end

  def post_type_icon(post)
    case post.class.name
    when 'Like'
      '👍'
    when 'Tweet'
      post.retweeted ? '♻️' : '🐦'
    else
      '📝'
    end
  end
end
