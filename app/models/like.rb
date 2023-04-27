class Like < ApplicationRecord
  scope :by_date, ->(date) { where(created_at: date.to_time.beginning_of_day..date.to_time.end_of_day) }

  def self.search(term)
    if term.present?
      search_terms = term.downcase.split(' ').map { |t| "%#{t}%" }
      where(search_query, *search_terms * 2).order(created_at: :desc)
    else
      order(created_at: :desc)
    end
  end

  def self.search_query
    '(lower(full_text) LIKE ? OR lower(screen_name) LIKE ?)'
  end

  def url
    expandedUrl
  end

  def user_url
    "https://twitter.com/i/user/#{user_id}"
  end

  def no_url_text
    full_text.gsub(%r{https?://\S+}, '')
  end

  def link_constructor(link)
    "<a href=\"#{link}\" target=\"_blank\" class=\"like_link\">#{link}</a>"
  end

  def text_with_links
    full_text&.gsub(%r{https?://\S+}) { |l| link_constructor(l) }
  end

  def links
    regex = full_text[%r{https?://\S+}]
    regex ? [{ url: regex }] : []
  end
end
