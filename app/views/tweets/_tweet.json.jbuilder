json.extract! tweet, :id, :created_at, :id, :id_str, :text, :truncated, :entities, :source, :in_reply_to_status_id, :in_reply_to_status_id_str, :in_reply_to_user_id, :in_reply_to_user_id_str, :in_reply_to_screen_name, :user, :geo, :coordinates, :place, :contributors, :is_quote_status, :retweet_count, :favorite_count, :favorited, :retweeted, :lang, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
