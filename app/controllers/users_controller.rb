class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(10)

  end
  
  def new
    @user = User.new
  end
  
  def edit
#    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      redirect_to root_path , notice: 'プロフィールを編集しました'
    else
      render 'edit'
    end
  end

  def index
    @user = User.new
    @users = User.all
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

 #favorites_user GET    /users/:id/favorites(.:format)  users#favorites
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorite_posts
  end
  

#followings_user GET    /users/:id/followings(.:format) users#followings
  def followings
    @user = User.find(params[:id])
    @follow = @user.following_users
  end

# followers_user GET    /users/:id/followers(.:format)  users#followers  
  def followers
    @user = User.find(params[:id])
    @follow = @user.follower_users
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    if @user != current_user
      redirect_to root_url
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :location)
  end
end