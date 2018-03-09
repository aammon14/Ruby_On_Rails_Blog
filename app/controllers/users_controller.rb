class UsersController < ApplicationController
  before_action :ensure_signed_out, only: [:new, :create]
  # before_action :ensure_signed_in, only: [:show, :index]

  # def show
  #   @user = User.find(params[:id])
  # end

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = "Welcome #{@user.username}"
      redirect_to articles_path
    else
      flash[:error] = @user.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "Account updated"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end