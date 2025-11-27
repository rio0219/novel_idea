class Post < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :idea_tags, dependent: :destroy
  has_many :tags, through: :idea_tags

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

  # 仮想属性（カンマ区切り入力用）
  attr_accessor :tag_names

  # 保存後にタグを更新
  after_save :save_tags

  def save_tags
    return if tag_names.blank?

    # 入力例「ruby,AI,アイデア」
    tag_list = tag_names.split(",").map(&:strip).uniq

    # 投稿に紐づくタグを一旦リセット
    self.tags = tag_list.map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end
  end

  # 表示用（編集フォームに既存タグを出す）
  def tag_names_display
    tags.pluck(:name).join(", ")
  end
end
