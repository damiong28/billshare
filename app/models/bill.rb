class Bill < ActiveRecord::Base
  #t.date :bill_date
  #t.decimal :bill_amount (calculated)
  #t.float :total_data 
  #t.decimal :data_cost
  #t.references :account
  #t.float :data_overage (calculated)
  
  validates :bill_amount, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_data, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :data_cost, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :data_overage, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  belongs_to :account
  has_many :charges
end
