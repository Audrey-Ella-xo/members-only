class PostsController < ApplicationController
  before_action :is_logged_in?, only: [:new, :create] 
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    @post.user_id = current_user.id

    @post.save

    redirect_to root_url
  end

  def index
    @posts = Post.all
  end
  
  private   
    def is_logged_in?
    redirect_to login_path unless logged_in?
    end 

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
