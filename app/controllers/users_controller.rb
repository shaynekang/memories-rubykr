class UsersController < ApplicationController
  def create
    auth = request.env['omniauth.auth']

    signup = Signup.new
    user = signup.authenticate!(auth)

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