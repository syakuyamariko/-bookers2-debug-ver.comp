class BooksController < ApplicationController
before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @book = Book.find(params[:id])
    @user = @book.user #
    @book_new = Book.new #詳細ページのフォームに対してからのモデルを作成
  end

  def index
    @books = Book.all
    @book = Book.new
    @book.id = current_user.id
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy #deleteをdestroyに修正
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end


def is_matching_login_user #追加した
    @book = Book.find(params[:id])
    user = User.find(@book.user_id)
    unless user.id == current_user.id
      redirect_to books_path
    end
  end
end