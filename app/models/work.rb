class Work < ApplicationRecord
  belongs_to :user
  belongs_to :genre

  validates :title, presence: true, length: { maximum: 100 }
  validates :theme, length: { maximum: 50 }, allow_blank: true
  validates :synopsis, length: { maximum: 1000 }, allow_blank: true
end
