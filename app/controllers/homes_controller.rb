class HomesController < ApplicationController
  def top
    @post_images = PostImage.includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}
  end

  def about
  end
end
