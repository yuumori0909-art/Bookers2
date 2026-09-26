class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    Current.user.follow(@user)
    redirect_to request.referer
  end

  def destroy
    @user = User.find(params[:user_id])
    Current.user.unfollow(@user)
    redirect_to request.referer
  end

  def followings #フォロー一覧
    @user = User.find(params[:user_id])
    @followings = @user.followings
  end

  def followers #フォロワー一覧
    @user = User.find(params[:user_id])
    @followers = @user.followers
  end
end
