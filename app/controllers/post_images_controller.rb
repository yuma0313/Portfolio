class PostImagesController < ApplicationController
  before_action :authenticate_user!, only: [:create,:edit,:update,:destroy]
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.user_id = current_user.id
    if @post_image.save
      flash[:success] = "投稿しました"
      redirect_to post_images_path
    else
      @post_images = PostImage.all.page(params[:page]).per(4)
      render'index'
    end
  end

  def index
    @post_image = PostImage.new
    @post_images = PostImage.all.page(params[:page]).per(4)
  end

  def show
    @post_image = PostImage.find(params[:id])
    @user = current_user
  end

  def edit
    @post_image = PostImage.find(params[:id])
    if @post_image.user.id == current_user.id
      render'edit'
    else
      redirect_to post_images_path
    end
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
       flash[:success] = "変更を保存しました"
       redirect_to post_image_path(@post_image)
    else
      render'edit'
    end
  end

  def search
    @post_images = PostImage.search(params)
  end

  private

  def post_image_params
    params.require(:post_image).permit(:name, :image, :caption, :address, :prefecture, :latitude, :longitude, :rate)
  end
end
