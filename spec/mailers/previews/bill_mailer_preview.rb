# Preview all emails at http://localhost:3000/rails/mailers/bill_mailer
class BillMailerPreview < ActionMailer::Preview
    def mail_bill
      BillMailer.mail_bill(Bill.find(3))
    end
end
