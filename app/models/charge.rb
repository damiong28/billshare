class Charge < ActiveRecord::Base
  #t.references :bill, index: true, foreign_key: true
  #t.references :user, index: true, foreign_key: true
  #t.decimal :surcharges, precision: 6, scale: 2
  #t.decimal :data_used, precision: 6, scale: 2
  #t.boolean :paid
  
  belongs_to :bill
  belongs_to :user
end
