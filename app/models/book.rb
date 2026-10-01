class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  #サーチ関係定義
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE ?", "#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE ?", "#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE ?", "%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE ?", "%#{word}%")
    else
      @book = Book.all
    end
  end

  #レビュー関連定義
  scope :latest, -> { order(created_at: :desc) }
  scope :star_count, -> { order(score: :desc) }

  # 空チェック
  validates :title, presence: true
  # 空チェック ＆ 200文字以内であること
  validates :body, presence: true, length: { maximum: 200 }

end
