# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
genres = %w[ファンタジー ミステリー 恋愛 SF ホラー エッセイ 児童書・童話 BL その他]
genres.each do |name|
  Genre.find_or_create_by!(name: name)
end
