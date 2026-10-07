class RoomsController < ApplicationController
  before_action :reject_non_related, only: [:show,]

  def create
    user_rooms = Room.between(Current.user.id, params[:user_id])

    if user_rooms.present?
      @room = Room.find(user_rooms.first)
    else
      @room = Room.create
      UserRoom.create(user_id: Current.user.id, room_id: @room.id)
      UserRoom.create(user_id: params[:user_id], room_id: @room.id)
    end

    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @another_user = @room.users.where.not(id: Current.user.id).first
    @messages = @room.messages
    @message = Message.new
  end

  private

  def reject_non_related
    @room = Room.find(params[:id])
    another_user = @room.users.where.not(id: Current.user.id).first
    
    unless Current.user.following?(another_user) && another_user.following?(Current.user)
      redirect_to books_path 
    end
  end
end
