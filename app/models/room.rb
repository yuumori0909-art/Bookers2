class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms
  has_many :messages, dependent: :destroy

  def self.between(user1_id, user2_id)
    UserRoom.where(user_id: [user1_id, user2_id])
            .group(:room_id)
            .having('COUNT(room_id) = 2')
            .pluck(:room_id)
  end
end
