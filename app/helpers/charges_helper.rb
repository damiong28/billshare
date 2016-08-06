module ChargesHelper
  
  def paid_boolean(charge)
    if charge.paid
      "paid"
    else
      "unpaid"
    end
  end
  
end
