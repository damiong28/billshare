class Bill < ActiveRecord::Base
  #t.date :date
  #t.decimal :amount, precision: 6, scale: 2
  #t.decimal :total_data, precision: 6, scale: 3
  #t.decimal :data_cost, precision: 6, scale: 2 
  #t.references :account, index: true, foreign_key: true, :null => false
  #t.decimal :balance, precision: 6, scale: 2
  #t.decimal :data_subtotal, precision: 6, scale: 3
  #t.decimal :percent_total, precision: 5, scale: 2
  #t.decimal :data_share_total, precision: 6, scale: 2
  #t.decimal :surcharges_total, precision: 6, scale: 2
  #t.decimal :subtotal, precision: 6, scale: 2
  
  validates :amount, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_data, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :data_cost, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :date, uniqueness: true
  
  belongs_to :account
  has_many :charges, dependent: :destroy
end
