class BillsController < ApplicationController
    before_action :authenticate_account!, only: [:show, :new, :create, 
      :edit, :destroy]
    before_action :correct_account, only: [:show, :edit, :update, :destroy, 
      :send_bill]
    
    
  def index
    if account_signed_in?
      @bills = Bill.where(:account_id => current_account.id).order(date: :desc)
      @users = User.where(:account_id => current_account.id)
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
    find_bill
    @charges = @bill.charges.order("user_id ASC")
  end
  
  def edit
    find_bill
  end
  
  def update
    find_bill
    if @bill.update_attributes(bill_params)
      flash[:success] = "Bill updated!"
      redirect_to @bill
    else
      render 'edit'
    end
  end
  
  def destroy
    find_bill
    @bill.destroy
    flash[:success] = "Bill deleted!"
    redirect_to bills_url
  end
  
  def send_bill
    find_bill
    BillMailer.mail_summary(@bill, current_account).deliver_later
    @bill.charges.each do |charge|
      if charge.user.a_manager?
        BillMailer.manager_bill(@bill, charge).deliver_later
      elsif charge.user.manager_id.present?
        # don't send stuff to managed user
      else
        BillMailer.mail_bill(@bill, charge).deliver_later
      end
    end
    flash[:success] = "Bill sent!"
    redirect_to root_path_url
  end
  
  private
    
    def bill_params
      params.require(:bill).permit(:date, :amount, :total_data, 
        :data_cost, :account_id, :data_overage)
    end
    
    def correct_account
      find_bill
      unless (@bill.account_id == current_account.id)
          flash[:danger]="That bill doesn't belong to you!"
          redirect_to root_path_url
      end
    end
    
    def find_bill
      @bill = Bill.find(params[:id])
    end
end