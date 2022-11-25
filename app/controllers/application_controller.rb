class ApplicationController < ActionController::Base
  
  #deviseのメソッドでログイン認証されていなければ、ログイン画面にリダイレクト
  before_action :authenticate_user!, except: [:top,:about]
  
  #初期の状態の場合、emailとパスワードしか受け取れないため、nameの受け取りを許可 
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ユーザー登録(sign_up)の際に、ユーザー名(name)のデーター操作を許可

  # deviseのメソッドでsign_in後にusers_idへ移動
  def after_sign_in_path_for(resource)
    # users_id_path
    user_path(resource)
  end
  
  # deviseのメソッドでsign_out後にaboutへ移動(不要)
  def after_sign_out_path_for(resource)
    root_path
  end



  protected
  
  # ストロングパラメーター
  
  # devise.rbでemailカラムの許可を削除し、nameカラムの許可をしたため
  # ユーザー登録(sign_up)の際に、ユーザー名(email)のデーター操作を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
 
end
