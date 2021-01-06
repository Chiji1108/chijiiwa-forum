class PostsController < ApplicationController
  before_action :set_my_thread
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_action :identity_verification, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = @my_thread.posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.my_thread = @my_thread
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to my_thread_post_path(@my_thread, @post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to my_thread_post_path(@my_thread, @post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to my_thread_posts_path(@my_thread), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_my_thread
      @my_thread = MyThread.find(params[:my_thread_id])
    end

    def identity_verification
      unless @post.user == current_user
        redirect_to my_thread_posts_url, alert: '作成者本人しかこの操作はできません。'
      end
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:my_thread_id, :content, :user_id)
    end
end
