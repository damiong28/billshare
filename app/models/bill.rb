class Bill < ActiveRecord::Base
  #t.date :bill_date
  #t.decimal :bill_amount, scale: 2, precision: 6
  #t.float :total_data
  #t.decimal :data_cost, scale: 2, precision: 6
  #t.references :account, index: true, foreign_key: true, :null => false
  
  validates :bill_amount, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_data, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :data_cost, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
  belongs_to :account
  has_many :charges
end
