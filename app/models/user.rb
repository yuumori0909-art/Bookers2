class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy  
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :books, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower


  validates :email_address, presence: true
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :password, length: { minimum: 6 }, allow_nil: true 
  validates :introduction, length: { maximum: 50 } 
 
  
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(user)
    relationships.create(followed_id: user.id)
  end
  
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }

end
