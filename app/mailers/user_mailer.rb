class UserMailer < ApplicationMailer
  default from: "Reminder@billshare.herokuapp.com"
  helper ChargesHelper
  layout 'mailer'
  
  def mail_reminder(user)
    @user = user
    @charges = Charge.where(:user_id => user.id, :paid => false)
    mail(to: @user.email, subject: "Reminder of open balance")
  end
end