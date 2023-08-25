class UsersController < ApplicationController
  def index
    user = User.all
  end

  def show
    @user = User.find(params[:id])
    @username = User.find(params[:id])
    @profile = User.find(params[:id])
    @job = User.find(params[:id])
    @prototypes = @user.prototypes
  end
end
