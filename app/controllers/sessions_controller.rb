class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    if (user = User.find_by(name: params[:name]))&.authenticate(params[:password])
      start_new_session_for user
      flash[:notice] = "Welcome! You have signed up successfully."#ログイン成功時フラッシュメッセージ
      redirect_to user_path(user)
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    after_logout_url
  end
end
