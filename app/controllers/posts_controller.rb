class PostsController < ApplicationController
 before_action :is_matching_login_user,only: [:edit, :update]


  def create
    @post=Post.new(post_params)
    @post.user_id=current_user.id
    @post.save
    redirect_to post_path(@post)
  end



  def index
    @posts=Post.all
    @post=Post.new

  end

  def show
    @post=Post.find(params[:id])
    @comment=Comment.new
  end

  def edit
    is_matching_login_user
    @post=Post.find(params[:id])
  end

  def update
    is_matching_login_user
    @post=Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post=Post.find(params[:id])
    @post.destroy
  end

  private
   def post_params
     params.require(:post).permit(:name, :caption, :image)
   end


def is_matching_login_user
  post=Post.find(params[:id])
  unless post.user_id=current_user.id
    redirect_to user_path(post.user.id)
  end
end

end