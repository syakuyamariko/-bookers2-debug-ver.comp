Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.htmlz
  devise_for :users #上から順にルーティングが読み込まれていく、devise_for :users、resourcesメソッドはこの順で記述する
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]
  resources :users, only: [:index,:show,:edit,:update]


  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  #devise_for :users
  #resources :books, only: [:index,:show,:edit,:create,:destroy,:update]
  #resources :users, only: [:index,:show,:edit,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
