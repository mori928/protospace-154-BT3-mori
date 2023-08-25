class PrototypesController < ApplicationController
  before_action :set_prototype, only: :show
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :ensure_correct_user, only: :destroy

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/'
    else
      render '/prototypes/new', status: :unprocessable_entity
    end
  end

  def edit
    @prototype = Prototype.find(params[:id])
    return if current_user == @prototype.user

    redirect_to root_path
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
    @prototype = Prototype.find(params[:id])
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(:protoname, :catchcopy, :concept, :image).merge(user_id: current_user.id)
  end

  def ensure_correct_user
    @prototype = Prototype.find(params[:id])
    return if current_user == @prototype.user

    redirect_to root_path
  end
end
