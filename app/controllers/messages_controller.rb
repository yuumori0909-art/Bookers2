class MessagesController < ApplicationController

  def create
    @message = Current.user.messages.new(message_params)
    if @message.save
      redirect_to room_path(@message.room_id)
    else
      @room = @message.room
      @another_user = @room.users.where.not(id: Current.user.id).first
      @messages = @room.messages
      render 'rooms/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:room_id, :body)
  end
end

