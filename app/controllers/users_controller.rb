class UsersController < ApplicationController
  before_action :logged_in_user, only:[:destroy, :show, :edit, :followers, :following]
  before_action :correct_user, only:[:destroy, :edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @dogs = @user.dogs
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Community of Dog!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.admin?
      flash[:danger] = "Cannot delete admin."
      redirect_to root_url
    else
      user.destroy
      flash[:success] = "User delete."
      redirect_to root_url
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  def friends
    @title = "Friends"
    @user = User.find(params[:id])
    @users = @user.followers.where(id:@user.following.ids)
    render 'show_follow'
  end


  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    def correct_user
      @user = User.find(params[:id])
      if !current_user.admin? && !current_user?(@user)
        redirect_to(root_url)
      end
    end
end
