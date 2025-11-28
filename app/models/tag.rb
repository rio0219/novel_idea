class Tag < ApplicationRecord
  has_many :idea_tags, dependent: :destroy
  has_many :posts, through: :idea_tags

  validates :name, presence: true, uniqueness: true

  # Ransackで検索可能にする
  def self.ransackable_attributes(_auth_object = nil)
    %w[name created_at updated_at id]
  end

  def self.ransackable_associations(_auth_object = nil)
    []
  end
end
