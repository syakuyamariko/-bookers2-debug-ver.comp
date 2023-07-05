class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    #redirect_to book_path(book) #←非同期通信を行う場合は、JavaScriptファイル（.js.erb）を使用してビューを更新するためコメントアウト
    #アクション内にrenderやredirect_toの記述がない場合、Railsは自動的に対応するJavaScriptファイルを探しに行きます。
    #例えば、create.js.erbという名前のファイルがあれば、それが読み込まれます。
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #redirect_to book_path(book) #←非同期通信を行う場合は、JavaScriptファイル（.js.erb）を使用してビューを更新するためコメントアウト
  end


  #private

  #def book_params
    #params.require(:book).permit(:title, :body)
  #end

end
