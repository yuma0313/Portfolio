class HomesController < ApplicationController
  def top
    @post_images = PostImage.includes(:favorited_users).limit(4).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
    @posts = PostImage.all
  end

  def about
  end
end
