class HomesController < ApplicationController
  def top
    @post_images = PostImage.includes(:favorited_users).limit(4).sort do |a, b|
      b.favorited_users.size <=> a.favorited_users.size
    end
    @posts = PostImage.all
    # @post_image = PostImage.all.order(rate :desk)
  end

  def about; end
end
