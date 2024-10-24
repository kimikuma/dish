class UsersController < ApplicationController
 before_action :is_matching_login_user,only: [:edit, :update]
  def show
    @user=User.find(params[:id])
    @posts=@user.posts
  end

  def index
    @users=User.all
  end

  def edit
    is_matching_login_user
    @user=User.find(params[:id])
  end

  def update
    is_matching_login_user
    @user=User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def is_matching_login_user
      user=User.find(params[:id])
      unless user.id==current_user.id
        redirect_to user_path(user)
      end
    end
end
