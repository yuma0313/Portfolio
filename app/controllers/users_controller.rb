class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @users = User.all
    @post_images = @user.post_images.all.page(params[:page]).per(4)
  end

  def edit
    @user = User.find(params[:id])
    if @user.id = current_user.id
      render'edit'
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    if current_user.email == 'guest@example.com'
      redirect_to request.referer
    else
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "変更を保存しました"
        redirect_to user_path(current_user)
      else
        render'edit'
      end
    end
  end

  def unsubscribe #退会画面
    @user = User.find(params[:id])
  end

  def withdraw #退会処理
    if current_user.email = 'guest@example.com'
      redirect_to request.referer
    else
      @user = current_user
      @user.update(is_valid: false)
      reset_session
      redirect_to root_path, notice: 'またのご利用をお待ちしております'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:profile_image)
  end

end
