class UsersController < ApplicationController
  def create
    auth = request.env['omniauth.auth']

    user = User.where(provider: auth['provider'], uid: auth['uid']).first_or_create

    user.name = auth['info']['name'] unless auth['info']['name'].blank?
    user.nickname = auth['info']['nickname'] unless auth['info']['nickname'].blank?
    user.nickname = auth['extra']['username'] unless auth['extra']['username'].blank?
    user.email = auth['info']['email'] unless auth['info']['email'].blank?
    user.avatar = auth['info']['image'] unless auth['info']['image'].blank?

    user.token = auth['credentials']['token']

    user.save!

    session[:user_id] = user.id
    redirect_to :root, notice: "Successfully Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root, notice: "Successfully Signed out!"
  end

  def failure
    redirect_to :back, error: params[:message]
  end
end