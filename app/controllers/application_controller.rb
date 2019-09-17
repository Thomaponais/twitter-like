class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login, except: [:index, :show]

  private
  def not_authenticated
    redirect_to login_path, alert: "ログインしてください！"
  end
end
