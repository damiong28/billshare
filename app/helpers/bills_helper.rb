module BillsHelper
  
  def data_subtotal(charges)
    data = 0
    charges.each do |charge|
      data += charge.data_used
    end
    data
  end
  
  def data_share_total(charges)
    total = 0
    charges.each do |charge|
      total += charge.data_share
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
  
  def bill_balance(charges)
    bal = 0
    charges.each do |charge|
      unless charge.paid
        bal += charge.personal_total
      end
    end
    bal
  end
  
  def surcharges_total(charges)
    total = 0
    charges.each do |charge|
      total += charge.surcharges
    end
    total
  end
  
  def percent_total(charges)
    total = 0
    charges.each do |charge|
      total += charge.data_percentage
    end
    total * 100
  end
  
  def get_class(charge_total, bill_total)
    if charge_total == bill_total
      return "text-success"
    else
      return "text-danger"
    end
  end
end


