module StatisticsHelper
  def bill_total_by_month
    line_chart @bills.pluck(:date, :amount), library: {
      #title: 'Bill Amount by Month',
      animation: {startup: true, duration: '750', easing: 'out'},
      vAxis: {
              allowDecimals: false,
              title: 'Bill Amount',
              format: '$###'
              },
      hAxis: {
        format: "MMM",
         title: 'Month',
         gridlines: { count: @bills.count }
      },
    }
  end
  
  def user_charge_chart
    line_chart @charges.pluck(:date, :personal_total), library: {
      #title: 'User Charges by Month',
      animation: {startup: true, duration: '750', easing: 'out'},
      vAxis: {
         allowDecimals: false,
         #title: 'User Total',
         format: '$###'
      },
      hAxis: {
        format: "MMM",
         #title: 'Month',
         gridlines: { count: @charges.count }
      }
    }
  end
end