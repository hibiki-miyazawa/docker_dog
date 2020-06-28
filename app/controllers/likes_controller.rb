class LikesController < ApplicationController
  before_action :logged_in_user, only:[:index]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    unless @micropost.iine?(current_user)
      @micropost.iine(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    if @micropost.iine?(current_user)
      @micropost.uniine(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def index
    @user = current_user
    @likes = Like.find_by(user_id: current_user.id)
    if @likes
      @microposts = @likes.micropost
    end
  end
end
