class PostsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :edit, :destroy, :create, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @post = Post.new
    render :new
  end

  def create
    post = current_user.posts.create(title: params[:title],
                                     content: params[:content],
                                     tag_names: params[:tags],
                                     written_at: DateTime.now)
    redirect_to post_path(post)
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    post = Post.find(params[:id])
    post.update(title: params[:title],
                content: params[:content],
                tag_names: params[:tags])
    redirect_to post_path(post)
  end

  def index
    @posts = Post.page(params[:page]).per(10)
    render :index
  end

  def show
    @post = Post.find(params[:id])
    render :show
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
end

