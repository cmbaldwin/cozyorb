# frozen_string_literal: true

# OhayoController
class OhayoController < ApplicationController
  before_action :flickr_photo, only: %i[flickr_bg]
  def index; end

  def flickr_bg
    @photo.sizes.each { |size| @photo_url = size['source'] if size['label'] == 'Large 2048' }
    @photo_url ||= @photo.sizes.last['source']
    @photo.exif['exif'].each do |exif_hash|
      @exif_data = { 'label' => exif_hash['raw'] } if exif_hash.is_a?(Hash)
    end

    render partial: 'background_image'
  end

  private

  def flickr_photo
    require 'flickr'

    user = Flickr.new(ENV['FLICKR_API_KEY'])
                 .users(ENV['FLICKR_USER'])
    total_photos = total_photos(user)
    @photo = user.photos('per_page' => '1', 'page' => rand(1..total_photos)).first
  end

  def total_photos(user)
    Rails.cache.fetch("total_photos/#{user.id}", expires_in: 1.week) do
      user.photos('per_page' => '1').total.to_i
    end
  end
end
