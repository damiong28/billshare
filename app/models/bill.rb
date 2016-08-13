class Bill < ActiveRecord::Base
  #t.date :date
  #t.decimal :amount, scale: 2, precision: 6
  #t.float :total_data
  #t.decimal :data_cost, scale: 2, precision: 6
  #t.references :account, index: true, foreign_key: true, :null => false
  
  validates :amount, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_data, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :data_cost, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :date, uniqueness: true
  
  belongs_to :account
  has_many :charges, dependent: :destroy
end
