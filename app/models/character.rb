class Character < ApplicationRecord
  belongs_to :work

  validates :name, presence: true
end
