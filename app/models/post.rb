class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :content, presence: true, length: { maximum: 1000 }
  validates :genre_id, presence: true

  # URLでidの代わりにuuidを使う
  def to_param
    uuid
  end

  def liked_by?(user)
    return false if user.nil?

    likes.exists?(user_id: user.id)
  end

  # Ransack 検索許可
  def self.ransackable_attributes(_auth_object = nil)
    %w[content genre_id created_at updated_at user_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user genre]
  end
end
