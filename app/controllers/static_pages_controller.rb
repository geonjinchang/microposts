class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  #    @microposts = Micropost.order(:created_at).page params[:id]
    end
  end
end
