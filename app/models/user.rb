class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy  
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy


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

  has_many :books, dependent: :destroy
  
  
  normalizes :email_address, with: ->(e) { e.strip.downcase }

end
