class FavoritesController < ApplicationController
  def index
  end

  def create
    @post_image = PostImage.find(params[:post_image_id])
    @favorite = @post_image.favorites.new(user_id: current_user.id)
    @favorite.save
    redirect_to request.referer
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    @favorite = @post_image.favorites.find_by(user_id: current_user.id)
    @favorite.destroy
    redirect_to request.referer
  end
end
