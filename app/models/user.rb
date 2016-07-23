class User < ActiveRecord::Base
  #t.string :name
  #t.string :email
  #t.references :account, index: true, foreign_key: true
  #t.text :message
  #t.decimal :balance, scale: 2, precision: 6
  has_many :charges
  belongs_to :account
  
end
