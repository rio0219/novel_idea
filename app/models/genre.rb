class Genre < ApplicationRecord
  has_many :works
  has_many :posts
end
