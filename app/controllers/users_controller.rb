class UsersController < ApplicationController
  before_action :authenticate_account!
    
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

  private
  
    def user_params
      params.require(:user).permit(:name, :email, :message, :account_id, 
                    :balance)
    end
end
