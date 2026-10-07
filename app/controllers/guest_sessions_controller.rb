class GuestSessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]
  def create
    user = User.guest
    start_new_session_for(user)
    redirect_to user_path(user), notice: "guestuserでログインしました。"
  end
end