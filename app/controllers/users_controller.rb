class UsersController < ApplicationController
  def index
    @users = User.all
    # @books = @user.books
    @user = User.find(current_user.id)   # 部分テンプレートファイルのためのインスタンス変数
    @book = Book.new   # 部分テンプレートファイルのためのインスタンス変数
   
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books   #特定ユーザー全ての投稿を取得
  end

  def edit
    @user = User.find(params[:id])
    # アクセス制限
    if @user != current_user
      redirect_to user_path(current_user)
    end  
  end
  
  def update
    @user = User.find(params[:id])
    # @user.update(user_params)
    if @user.update(user_params)
      flash[:success]= 'You have updated user successfully.'
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end  
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end