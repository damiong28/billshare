class Bill < ActiveRecord::Base
    #t.string :month
    #t.decimal :bill_amount (calculate_
    #t.float :total_data 
    #t.decimal :data_cost
    #t.references :account
    #t.float :data_overage (calculated)

  belongs_to :account
end
