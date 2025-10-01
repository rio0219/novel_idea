class Worldview < ApplicationRecord
  belongs_to :work


  validates :country, presence: true
  validates :culture, presence: true
end
