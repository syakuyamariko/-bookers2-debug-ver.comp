class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]
  #before_action :set_user, only: [:followings, :followers] #フォロワー一覧画面の表示実装で追加

  def show
    @user = User.find(params[:id])
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
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

