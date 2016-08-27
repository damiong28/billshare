class ChargesController < ApplicationController
   before_action :authenticate_account!
   before_action :correct_account, only: [:edit, :destroy, :update, :mark_paid]
  
  def new
    @charge = Charge.new
  end
  
  def create
    @charge = Charge.new(charge_params)
    if @charge.save
      flash[:success] = "Charge added!"
      redirect_to bill_url(params[:bill_id])
    else
      render 'new'
    end
  end
  
  def edit
    @charge = Charge.find_by(:bill_id => params[:bill_id], :id => params[:id])
  end
  
  def update
    @charge = Charge.find_by(:bill_id => params[:bill_id], :id => params[:id])
    if @charge.update_attributes(charge_params)
        flash[:success] = "Charge updated!"
        redirect_to bill_url(params[:bill_id])
    else
        render 'edit'
    end
  end
  
  def destroy
    @charge = Charge.find_by(:bill_id => params[:bill_id], :id => params[:id])
    @charge.destroy
    flash[:success] = "Charge deleted!"
    redirect_to bill_url(params[:bill_id])
  end
    
  private
  
  def charge_params
    params.require(:charge).permit(:user_id, :surcharges, :data_used, 
        :account_id, :bill_id, :paid, :data_percentage, :data_share, 
        :personal_total)
  end
  
  def correct_account
      @charge = Charge.find_by(:bill_id => params[:bill_id], :id => params[:id])
      unless @charge.account_id == current_account.id
        flash[:warning]="That charge doesn't belong to you!"
        redirect_to root_path_url
      end
  end
end
