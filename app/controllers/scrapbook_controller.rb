# frozen_string_literal: true

# ScrapbookController
class ScrapbookController < ApplicationController
  before_action :set_vars, only: %i[index search_results]

  def index; end

  def search_results; end

  private

  def set_vars
    @term = term
    @search_date = search_params[:date] ? Date.parse(search_params[:date]) : Time.zone.today
    @tweets = @term ? Tweet.search(@term) : Tweet.by_date(@search_date)
    @likes = @term ? Like.search(@term) : Like.by_date(@search_date)
    @all_posts = @tweets + @likes
  end

  def term
    search_params[:term].present? ? search_params[:term] : nil
  end

  def search_date
    search_params[:date].present? ? Date.parse(search_params[:date]) : Time.zone.today
  end

  def search_params
    params.permit(:date, :term, :commit, :format, :authenticity_token)
  end
end
