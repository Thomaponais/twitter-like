class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :new, :create]
  before_action :require_user_permission, :only => [:edit, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_user_not_found

  # GET /users
  # GET /users.json
  def index
    @users = User.page(params[:page]).per(10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @users_tweets = @user.tweets.order(created_at: :desc).roots.page(params[:tweets_page]).per(25)
    @users_withanswers = @user.tweets.all.order(created_at: :desc).page(params[:withanswers_page]).per(25)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        auto_login(@user)
        format.html { redirect_to root_path, notice: 'ユーザー登録が完了しました。' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_back fallback_location: root_path, notice: 'ユーザー情報の変更が完了しました。' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'ユーザーの削除が完了しました。' }
      format.json { head :no_content }
    end
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js { render layout: false }
    end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@user)
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js { render layout: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :current_password,:password, :password_confirmation, :salt, :avatar)
    end

    def require_user_permission
      if logged_in? && @user != current_user
        redirect_to edit_user_path(current_user)
      elsif not logged_in?
        redirect_to login_path, alert: "ログインしてください！"
      end
    end

    def handle_user_not_found
      redirect_to root_path, alert: "このユーザーは存在していません"
    end

end
