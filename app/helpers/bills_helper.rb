module BillsHelper
  
  def bill_balance(charges)
    bal = 0
    charges.each do |charge|
      unless charge.paid
        bal += charge.personal_total
      end
    end
    bal
  end
  
  def get_class(charge_total, bill_total)
    if charge_total == bill_total
      return "text-success"
    else
      return "text-danger"
    end
  end
end