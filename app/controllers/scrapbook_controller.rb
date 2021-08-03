class ScrapbookController < ApplicationController

	def index
		search_params[:date] ? @search_date = Date.parse(params[:date]) : @search_date = Date.today
		@tweets = Tweet.by_date(@search_date)
		@tweets_ly = Tweet.by_date(@search_date - 1.year)
		@likes = Like.by_date(@search_date)
		@likes_ly = Like.by_date(@search_date - 1.year)
		@posts = @tweets + @likes
		@posts_ly = @tweets_ly + @likes_ly
	end

	private

		def search_params
			params.permit(:date)
		end

end
