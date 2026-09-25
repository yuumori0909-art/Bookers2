class BookComment < ApplicationRecord

  belongs_to :user
  belongs_to :book

  # 空チェック
  validates :comment, presence: true

end
