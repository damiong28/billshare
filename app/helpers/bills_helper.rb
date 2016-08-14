module BillsHelper
  
  def get_class(charge_total, bill_total)
    if charge_total == bill_total
      return "text-success"
    else
      return "text-danger"
    end
  end
end