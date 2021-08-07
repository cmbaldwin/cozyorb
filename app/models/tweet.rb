class Tweet < ApplicationRecord
	serialize :user
	serialize :entities

	scope :by_date, ->(date) { where(created_at: date.to_time.beginning_of_day..date.to_time.end_of_day) }

	def self.search(term)
		if term
			where('text LIKE :search', search: "%#{term}%").order(created_at: :desc)
		else
			order(created_at: :desc)
		end
	end

	def url
		user_id = 'anyone'
		user.nil? ? () : (user[:id_str].nil? ? () : (user_id = user[:id_str]))
		"https://twitter.com/" + user_id.to_s + "/status/" + id.to_s
	end


	def no_url_text
		text.gsub(/https?:\/\/[\S]+/, '')
	end

	def text_with_links
		text.gsub(/https?:\/\/[\S]+/) { |l| "<a href=\"#{l}\" target=\"_blank\" class=\"tweet_link\">#{l}</a>" }
	end

	def retweeted_text
		rt_info = no_url_text.scan(/RT.*?\:\ /).first
		rt_text = text_with_links.gsub(rt_info, '')
		{info: rt_info, text: rt_text}
	end

	def has_image? #images
		entities["media"] ? !entities["media"].empty? : false
	end

	def image
		image_hash = entities["media"].first
		if image_hash["type"] == "photo"
			image_hash
		end
	end

	def image_format
		image["media_url_https"].scan(/(?<=\.).{3}\Z/).first
	end

	def image_url
		image.empty? ? '' : (image["media_url_https"] + "?format=#{image_format}&name=large")
	end

	def has_mentions? #interactions
		entities["user_mentions"] ? !entities["user_mentions"].empty? : false
	end

	def has_hashtags? #hashtags
		entities["hashtags"] ? !entities["hashtags"].empty? : false
	end

	def has_urls? #external links
		entities["urls"] ? !entities["urls"].empty? : false
	end

	def has_symbols? #this is for financial stuff primarly eg $BTC
		entities["symbols"] ? !entities["symbols"].empty? : false
	end

	def links
		links = Array.new
		entity_links = entities[:urls]
		regex = text[/https?:\/\/[\S]+/]
		if entity_links.empty? && regex
			links = [{url: regex}]
		else
			links = entity_links
		end
		links
	end

end
