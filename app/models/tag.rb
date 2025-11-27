class Tag < ApplicationRecord
  has_many :idea_tags, dependent: :destroy
  has_many :posts, through: :idea_tags

  validates :name, presence: true, uniqueness: true
end
