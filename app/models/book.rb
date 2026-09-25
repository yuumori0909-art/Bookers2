class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  # 空チェック
  validates :title, presence: true
  # 空チェック ＆ 200文字以内であること
  validates :body, presence: true, length: { maximum: 200 }

end
