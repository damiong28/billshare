class BillMailer < ApplicationMailer
  default from: "BillShare@billshare.herokuapp.com"
  layout 'mailer'
  
  def mail_bill(charge)
    @charge = charge
    @user = User.find(charge.user_id)
    @bill = Bill.find(charge.bill_id)
    mail(to: @user.email, subject: "#{@bill.date.strftime("%B")} Phone Bill")
  end
  
  def mail_charge(charge)
    @charge = charge
    @user = User.find(charge.user_id)
    @bill = Bill.find(charge.bill_id)
    mail(to: @user.email, subject: "#{@bill.date.strftime("B")} Phone Bill")
  end
end