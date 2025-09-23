class Work < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :characters, dependent: :destroy
  has_one :worldview, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :theme, length: { maximum: 50 }, allow_blank: true
  validates :synopsis, length: { maximum: 1000 }, allow_blank: true
end
