class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]
  #before_action :set_user, only: [:followings, :followers] #フォロワー一覧画面の表示実装で追加

  def show
    @user = User.find(params[:id]) #userをネストすることで、IDが変わってしまうため(params[:user_id])とする
    @books = @user.books
    @book = Book.new
  end

  def index
    @user = User.find_by(params[:users_id]) #指定した id が存在しないことが想定される場合 → find_by メソッドを使う
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def followings #フォロワー一覧画面の表示実装で追加
    @users = @user.followings
  end

  def followers #フォロワー一覧画面の表示実装で追加
    @users = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image,)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  end

