class BookmarksController < ApplicationController
  def create
    @post_image = PostImage.find(params[:post_image_id])
    @bookmark = @post_image.bookmarks.new(user_id: current_user.id)
    @bookmark.save
    redirect_to request.referer
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    @bookmark = @post_image.bookmarks.find_by(user_id: current_user.id)
    @bookmark.destroy
    redirect_to request.referer
  end
end
