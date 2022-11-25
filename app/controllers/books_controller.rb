class BooksController < ApplicationController
  def new
    @book = Book.new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # current_user:ログイン中のユーザーを取得しbookテーブルのuser_idカラムに代入
    # @books = Book.all
    if @book.save
      flash[:success]= 'You have created book successfully.'
      redirect_to book_path(@book.id)
    else
      # redirect_to books_path
      @books = Book.all
      @user = User.find(current_user.id)   # 部分テンプレートファイルのためのインスタンス変数
  
      render :index   #renderの時は遷移先のアクションを入れておく
    end
    
  end  

  def index
    @books = Book.all
    # @book = Book.find(params[:id])
    # @user = @book.user
    @user = User.find(current_user.id)   # 部分テンプレートファイルのためのインスタンス変数
    @book = Book.new   # 部分テンプレートファイルのためのインスタンス変数
  end

  def show
    @book = Book.find(params[:id])   #params[:id]はurlから情報をとる
    @user = @book.user
    @nilbook = Book.new   #部分テンプレートファイルのためのインスタンス変数
    
  end
  
  def edit
    @book = Book.find(params[:id])
    # アクセス制限
    if  @book.user != current_user
      redirect_to books_path
    end
    
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:success]= 'You have updated book successfully.'
      redirect_to book_path(@book.id)
    else
      render :edit
    end  
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end  
  
  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
