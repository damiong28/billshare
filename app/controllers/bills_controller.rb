class BillsController < ApplicationController
    before_action :authenticate_account!, only: [:show, :new, :create, 
    :edit, :destroy]
    before_action :correct_account, only: [:show, :edit, :update, :destroy]
    
    
  def index
    if account_signed_in?
      @bills = Bill.where(:account_id => current_account.id)
    end
  end
  
  def new
    @bill = Bill.new
  end
  
  def create
    @bill = Bill.new(bill_params)
    if @bill.save
      redirect_to @bill
    else
      render 'new'
    end
  end
  
  def show
    @bill = Bill.find(params[:id])
    @charges = @bill.charges
  end
  
  def edit
    @bill = Bill.find(params[:id])
  end
  
  private
    
    def bill_params
      params.require(:bill).permit(:bill_date, :bill_amount, :total_data, :data_cost,
        :account_id, :data_overage)
    end
    
    def correct_account
      @bill = Bill.find(params[:id])
      unless (@bill.account_id == current_account.id)
          flash[:danger]="That bill doesn't belong to you!"
          redirect_to root_path_url
      end
    end
end