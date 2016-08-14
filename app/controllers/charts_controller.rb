class ChartsController < ApplicationController
  
  def bill_total_by_month
    @bills = Bill.where(:account_id => current_account.id)
    result = @bills.pluck(:bill_date, :bill_amount)
    render json: [{name: 'Bill Amount', data: result}]
  end
  
   def user_charge_chart
    @charges = Charge.where(:user_id => params[:id])
    result = @charges.pluck(:date, :personal_total)
    render json: [{name: 'Charge Amount', data: result}]
  end
  
  def user_balance_chart
    @users = User.where(:account_id => current_account.id)
    result = @users.pluck(:name, :balance)
    render json: [{name: 'User Balance', data: result}]
  end
end