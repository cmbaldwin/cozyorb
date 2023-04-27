class Tweet < ApplicationRecord
  serialize :user
  serialize :entities

  scope :by_date, ->(date) { where(created_at: date.to_time.beginning_of_day..date.to_time.end_of_day) }

  def self.search(term)
    if term.present?
      search_terms = term.downcase.split(' ')
      query_string = search_terms.map { |_t| 'lower(text) LIKE ?' }.join(' OR ')
      where(query_string, *search_terms.map { |t| "%#{t}%" }).order(created_at: :desc)
    else
      order(created_at: :desc)
    end
  end

  def self.search_query
    'lower(text) LIKE ?'
  end

  def url
    user_id = 'anyone'
    user_id ||= user['id']
    URI.parse("https://twitter.com/#{user_id}/status/#{id_str}").to_s
  end

  def no_url_text
    text.gsub(%r{https?://\S+}, '')
  end

  # def text_with_links
  #   text.gsub(%r{\Ahttps?://(?:\S+|t\.co/[a-zA-Z0-9]+)}) do |link|
  #     format('<a href="%<link>s" target="_blank" class="tweet_link">%<link>s</a>', link)
  #   end
  # end

  def text_with_links
    text.gsub(%r{https?://\S+}) { |l| "<a href=\"#{l}\" target=\"_blank\" class=\"tweet_link\">#{l}</a>" }
  end

  def retweeted_text
    rt_info = no_url_text.scan(/RT.*?:\ /).first
    rt_text = text_with_links.gsub(rt_info, '')
    { info: rt_info, text: rt_text }
  end

  def image?
    entities['media'] ? !entities['media'].empty? : false
  end

  def image
    image_hash = entities['media'].first
    return image_hash if image_hash['type'] == 'photo'
  end

  def image_format
    image['media_url_https'].scan(/(?<=\.).{3}\Z/).first
  end

  def image_url
    image.empty? ? '' : (image['media_url_https'] + "?format=#{image_format}&name=large")
  end

  def mentions?
    entities['user_mentions'] ? !entities['user_mentions'].empty? : false
  end

  def hashtags?
    entities['hashtags'] ? !entities['hashtags'].empty? : false
  end

  def urls?
    entities['urls'] ? !entities['urls'].empty? : false
  end

  def symbols?
    entities['symbols'] ? !entities['symbols'].empty? : false
  end

  def links
    entity_links = entities[:urls]
    regex = text[%r{https?://\S+}]
    return [{ url: regex }] if entity_links.empty? && regex

    entity_links
  end
end
