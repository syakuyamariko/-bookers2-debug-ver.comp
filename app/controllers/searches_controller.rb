class SearchesController < ApplicationController
  before_action :authenticate_user!#全てのアクションの前に、ユーザーがログインしているかどうか確認

  def search
    @model = params[:model] #ユーザーが選択した検索対象のモデル（"user" または "book"）を @model 変数に代入しています。
    @content = params[:content] #ユーザーが入力した検索キーワードを @content 変数に代入しています
    @method = params[:method] #ユーザーが選択した検索方法（"perfect"、"forward"、"backward"、"partial"）を @method 変数に代入しています

    # 選択したモデルに応じて検索を実行
    if @model  == "user" # 選択されたモデルが "user" である場合の条件分岐です。ユーザーの検索を行います。
      @records = User.search_for(@content, @method) #選択された検索対象（ユーザー）に対して、search_for メソッドを呼び出して検索を実行し、結果を @records 変数に代入。
    else
      @records = Book.search_for(@content, @method) #選択された検索対象（書籍）に対して、search_for メソッドを呼び出して検索を実行し、結果を @records 変数に代入します。
    end
  end
end

