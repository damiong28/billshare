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
    @data_subtotal = data_subtotal(@charges)
    @percent_total = percent_total(@charges)
    @data_share_total = data_share_total(@charges)
    @surcharges_total = surcharges_total(@charges)
    @bill_subtotal = bill_subtotal(@charges)
  end
  
  def edit
    @bill = Bill.find(params[:id])
  end
  
  def update
    @bill = Bill.find(params[:id])
    if @bill.update_attributes(bill_params)
      flash[:success] = "Bill updated!"
      redirect_to @bill
    else
      render 'edit'
    end
  end
  
  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy
    flash[:success] = "Bill deleted!"
    redirect_to bills_url
  end
  
  def send_bill
    @bill = Bill.find(params[:id])
    BillMailer.mail_bill(@bill).deliver_later
    flash[:success] = "Bill sent!"
    redirect_to root_path_url
  end
  
  private
    
    def bill_params
      params.require(:bill).permit(:bill_date, :bill_amount, :total_data, 
        :data_cost, :account_id, :data_overage)
    end
    
    def correct_account
      @bill = Bill.find(params[:id])
      unless (@bill.account_id == current_account.id)
          flash[:danger]="That bill doesn't belong to you!"
          redirect_to root_path_url
      end
    end
    
    def data_subtotal(charges)
      data = 0
      charges.each do |charge|
        data += charge.data_used
      end
      data
    end
    
    def percent_total(charges)
      total = 0
      charges.each do |charge|
        total += charge.data_percentage
      end
      total * 100
    end
    
    def data_share_total(charges)
      total = 0
      charges.each do |charge|
        total += charge.data_share
      end
      total
    end
    
    def surcharges_total(charges)
      total = 0
      charges.each do |charge|
        total += charge.surcharges
      end
      total
    end
    
    def bill_subtotal(charges)
      sub = 0
      charges.each do |charge|
        sub += charge.personal_total
      end
      sub
    end
end