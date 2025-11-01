class User < ApplicationRecord
  has_many :works, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :ai_consultations, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_one_attached :image
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 名前が未設定の場合のデフォルト
  def display_name
    name.present? ? name : "名無しさん"
  end

  # 表示用画像（ActiveStorage or assetファイル）
  def display_image(size: [ 120, 120 ])
    if image.attached? && image.variable?
      image.variant(resize_to_fill: size)
    else
      ActionController::Base.helpers.asset_path("default_user.PNG")
    end
  end
end
