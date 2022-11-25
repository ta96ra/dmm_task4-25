# Booksモデル
class Book < ApplicationRecord
  
  # ActiveStorageを使って画像を持たせる
  # has_one_attached :image
  
  #userテーブルと関連付(N)
  belongs_to :user
  
  # バリデーションの設定
  # titleは空でないように設定
  validates :title, presence: true
  #bodyは空でなくかつ２００文字以内
  validates :body, presence: true, length: {maximum: 200}
end
