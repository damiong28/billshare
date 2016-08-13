class BillMailer < ApplicationMailer
  default from: "notifications@billshare.herokuapp.com"
  layout 'mailer'
  
  def mail_bill(bill)
    bill.charges.each do |charge|
      @charge = charge
      @user = User.find(charge.user_id)
      @bill = Bill.find(charge.bill_id)
      mail(to: @user.email, subject: "#{@bill.date} Phone Bill")
    end
  end
  
  def mail_charge(charge)
    @charge = charge
    @user = User.find(charge.user_id)
    @bill = Bill.find(charge.bill_id)
    mail(to: @user.email, subject: "#{@bill.date} Phone Bill")
  end
end