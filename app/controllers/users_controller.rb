class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @users = User.all
    @post_images = @user.post_images.all.page(params[:page]).per(4)
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render 'edit'
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "変更を保存しました"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  # 退会画面
  def unsubscribe
    @user = User.find(params[:id])
  end

  # 退会処理(論理削除)
  def withdraw
    if current_user.email == 'guest@example.com' #ゲストユーザーのメールアドレスなら退会できない
      redirect_to request.referer
      flash[:danger] = 'テストユーザーは退会できません'
    else
      User.transaction do #データベースの削除
        @user = User.find(params[:id])
        @user.post_images.delete_all #投稿データの削除
        @user.favorites.delete_all #いいねデータの削除
        @user.update(is_valid: false) #falseになる
        reset_session #セッション内のデータを全て削除する
      end
      redirect_to root_path
      flash[:notice] = 'またのご利用をお待ちしております'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
