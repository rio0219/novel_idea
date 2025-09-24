class Plot < ApplicationRecord
  belongs_to :work

  validates :chapter_title, presence: true
end
