class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  # has_many :likes, dependent: :destroy

  validates :content, presence: true, length: { maximum: 1000 }
  validates :genre_id, presence: true
end
