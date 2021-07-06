class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # 全てのコントローラーに処理を実行する前に指定したメソッドを実行させる。
  # ifオプション :メソッド名 返り値がtrueのときのみ指定したメソッドを実行。
  # devise_controller? deviseのコントローラーかどうかを判断するdeviseのヘルパーメソッド。

  private
  def configure_permitted_parameters
    # deviseに新たに定義するメソッドの慣習名
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    # devise_parameter_sanitizer.permit(:deviseの処理名, keys: [:許可するキー(カラム名)])
  end
end
