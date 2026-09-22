class Book < ApplicationRecord

  belongs_to :user

  # 空チェック
  validates :title, presence: true

  # 空チェック ＆ 200文字以内であること
  validates :body, presence: true, length: { maximum: 200 }

end
