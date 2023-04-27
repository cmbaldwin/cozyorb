class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_rich_text :content
  has_rich_text :content_ja

  validates :title, presence: true
  validates :content, presence: true

  # Published posts in order of created_at
  scope :published, -> { where(published: true).order(created_at: :desc) }
end
