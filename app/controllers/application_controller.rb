class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about ]#ログイン認証が済んでいない状態でトップページ以外の画面にアクセスしても、ログイン画面へリダイレクトする
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for(resource)
    current_user  #users_path(@user.id)をcurrent_userに修正
  end


  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
