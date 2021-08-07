module ScrapbookHelper

	def border_color(post)
		tweet = post.class.name == 'Tweet'
		tweet ? (retweet = post.retweeted) : (retweet = false)
		tweet ? (retweet ? 'border-success' : 'border-primary') : 'border-info'
	end

end
