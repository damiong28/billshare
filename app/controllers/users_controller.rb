class UsersController < ApplicationController
  before_action :authenticate_account!
  before_action :correct_account, only: [:edit, :show, :destroy, :update, 
    :send_reminder]
    
  def index
    @users = User.where(:account_id => current_account.id)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User created!"
      redirect_to users_url
    else
      render 'new'
    end
  end
  
  def show
    @user=User.find(params[:id])
    @charges = @user.charges.order(date: :desc)
  end
  
  def edit
    @user=User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "User updated!"
      redirect_to users_url
    else
      render 'edit'
    end
  end
  
  def destroy
    @user=User.find(params[:id])
    @user.destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  def send_reminder
    @user = User.find(params[:id])
    UserMailer.mail_reminder(@user).deliver_later
    flash[:success] = "Reminder sent!"
    redirect_to @user
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :message, :account_id, 
        :balance)
    end
    
    def correct_account
      @user = User.find(params[:id])
      unless @user.account_id == current_account.id
        flash[:warning] = "That user doesn't belong to you!"
        redirect_to root_path_url
      end
    end
end
