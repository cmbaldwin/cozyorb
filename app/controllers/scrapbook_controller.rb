class ScrapbookController < ApplicationController

	def index
		@term = search_params[:term] if search_params[:term]
		unless @term
			search_params[:date] ? @search_date = Date.parse(params[:date]) : @search_date = Date.today
			@tweets = Tweet.by_date(@search_date)
			@likes = Like.by_date(@search_date)
			@all_posts = @tweets + @likes
		else
			@search_date = Date.today
			@tweets = Tweet.search(@term)
			@likes = Like.search(@term)
			@all_posts = @tweets + @likes
		end
	end

	private

		def search_params
			params.permit(:date, :term)
		end

end
