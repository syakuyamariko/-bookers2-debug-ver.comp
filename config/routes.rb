Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlz
  devise_for :users #上から順にルーティングが読み込まれていく、devise_for :users、resourcesメソッドはこの順で記述する
  root :to =>"homes#top"
  get "home/about"=>"homes#about"
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do

  resource :favorites, only: [:create, :destroy] #いいね機能のルーティングを設定
  resources :book_comments, only: [:create, :destroy] #コメント機能の設定
  end
  resources :users, only: [:index,:show,:edit,:update]

end
