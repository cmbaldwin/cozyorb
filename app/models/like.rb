class Like < ApplicationRecord

  scope :by_date, ->(date) { where(created_at: date.to_time.beginning_of_day..date.to_time.end_of_day) }
  
  def self.search(term)
    if term
      where('full_text LIKE :search OR screen_name LIKE :search', search: "%#{term}%").order(created_at: :desc)
    else
      order(created_at: :desc)
    end
  end

  def url
    expandedUrl
  end

  def user_url
    "https://twitter.com/i/user/#{user_id}"
  end

  def no_url_text
    full_text.gsub(/https?:\/\/[\S]+/, '')
  end

  def link_constructor(link)
    "<a href=\"#{link}\" target=\"_blank\" class=\"like_link\">#{link}</a>"
  end

  def text_with_links
    full_text.nil? ? full_text.gsub(/https?:\/\/[\S]+/) { |l| link_constructor(l) } : full_text
  end

  def links
    regex = full_text[/https?:\/\/[\S]+/]
    regex ? [{url: regex}] : []
  end

end
