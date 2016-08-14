module StatisticsHelper
  def bill_total_by_month
    line_chart @bills.pluck(:date, :amount), library: {
      animation: {startup: true, duration: '750', easing: 'out'},
      vAxis: {
              allowDecimals: false,
              format: '$###'
              },
      hAxis: {
        format: "MMM",
         gridlines: { count: @bills.count }
      },
    }
  end
  
  def user_charge_chart
    line_chart @charges.pluck(:date, :personal_total), library: {
      animation: {startup: true, duration: '750', easing: 'out'},
      vAxis: {
         allowDecimals: false,
         format: '$###'
      },
      hAxis: {
        format: "MMM",
        gridlines: { count: @charges.count }
      }
    }
  end
  
  def user_balance_chart
    column_chart @users.pluck(:name, :balance), library: {
      animation: {startup: true, duration: '750', easing: 'out'},
      vAxis: {
         allowDecimals: false,
         format: '$###',
         title: 'Balance'
      },
      hAxis: {
        gridlines: { count: @users.count }
      }
    }
  end
end