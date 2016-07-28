class Charge < ActiveRecord::Base
  #t.references :bill, index: true, foreign_key: true
  #t.references :user, index: true, foreign_key: true
  #t.decimal :surcharges, precision: 6, scale: 2
  #t.decimal :data_used, precision: 6, scale: 2
  #t.boolean :paid
  
  validates :user_id, presence: true
  validates :surcharges, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :data_used, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
  belongs_to :bill
  belongs_to :user
  belongs_to :account
end
