class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,   #パスワードの正確性を検証
         :registerable,   #ユーザ登録や編集、削除
         :recoverable,   #パスワードをリセット
         :rememberable,   #ログイン情報を保存
         :validatable    #emailのフォーマットなどのバリデーション
         
  has_many :books, dependent: :destroy   #Booksモデルと関連付(1)
  
  has_one_attached :profile_image
  # profile_imageという名前でActiveStrageのプロフィール画像を保存
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #バリデーションの設定
  #nameは一意性を持たせ、かつ2~20文字以内
  validates :name, uniqueness: true, length: {in: 2..20}
  #introductionは最大50文字まで
  validates :introduction, length: {maximum: 50}
end
