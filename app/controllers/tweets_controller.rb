class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :require_user_permission, :only => [:edit, :update, :destroy, :like, :unlike]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_tweet_not_found

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = Tweet.all.order(created_at: :desc).page(params[:page]).per(25)
    @tweet = Tweet.new
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = current_user.tweets.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = current_user.tweets.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'ツーイトの投稿が完了しました。' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to root_path, notice: 'ツーイトの編集が完了しました。' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'ツーイトの削除が完了しました。' }
      format.json { head :no_content }
    end
  end

  def like
    @tweet.liked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js { render layout: false }
    end
  end

  def unlike
    @tweet.unliked_by current_user
    respond_to do |format|
      format.html { redirect_back fallback_location: root_path }
      format.js { render layout: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:tweet, :parent_id)
    end

    def require_user_permission
      if logged_in? && @tweet.user != current_user
        redirect_to root_path
      elsif not logged_in?
        redirect_to login_path, alert: "ログインしてください！"
      end
    end

    def handle_tweet_not_found
      redirect_to root_path, alert: "このツイートは存在していません"
    end
end
