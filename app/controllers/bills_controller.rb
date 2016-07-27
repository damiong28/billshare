class BillsController < ApplicationController
    before_action :authenticate_account!, only: [:show, :new, :create, 
    :edit, :destroy]
    
    
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
  end
  
  def edit
    @bill = Bill.find(params[:id])
  end
  
  private
    
    def bill_params
      params.require(:bill).permit(:bill_date, :bill_amount, :total_data, :data_cost,
        :account_id, :data_overage)
    end
end