class HomesController < ApplicationController
  def top
    @post_images = PostImage.includes(:favorited_users).limit(4).sort do |a, b| #いいねの多い4つを表示
      b.favorited_users.size <=> a.favorited_users.size
    end
    @posts = PostImage.all
  end

  def about; end
end
