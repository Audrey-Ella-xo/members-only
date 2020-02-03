class PostsController < ApplicationController
  before_action :is_logged_in?, only: [:new, :create] 
  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    redirect_to root_url
  end

  def index
    @posts = Post.all
  end
  
  private   
    def is_logged_in?
    redirect_to login_path unless logged_in?
    end 

    def comment_params
      params.require(:post).permit(:title, :body, current_user)
    end
end
