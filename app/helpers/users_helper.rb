module UsersHelper
  
  def get_user_balance(charges)
    bal = 0
    charges.each do |charge|
      unless charge.paid
        bal += charge.personal_total
      end
    end
    bal
  end
  
end
