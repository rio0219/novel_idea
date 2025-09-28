class User < ApplicationRecord
  has_many :works, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :ai_consultations, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 名前が未設定の場合のデフォルト
  def display_name
    name.present? ? name : "名無しさん"
  end

  # イニシャルアイコン用
  def initial_icon
    display_name[0].upcase
  end
end
