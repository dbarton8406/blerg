class PostsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit, :destroy, :create, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
    render :new
  end

  def create
    post = current_user.posts.create(post_params)
    redirect_to post_path(post)
  end

  def edit
    @post = Post.find(params[:id])
#    binding.pry
    render :edit
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post)
  end

  def index
    @posts = Post.page(params[:page]).per(10)
    render :index
  end

  def show
    @comment = Comment.new
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @post }
      #format.json { render "show.json.jbuilder", status: :ok }
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user.id == post.user_id
      flash[:notice] = "Destroyed the post: #{post.title}"
      post.destroy
    else
      flash[:notice] = "I can't let you do that, Dave."
    end
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :tag_names, :content)
  end
end

