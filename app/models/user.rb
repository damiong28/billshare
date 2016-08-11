class User < ActiveRecord::Base
  #t.string :name
  #t.string :email
  #t.references :account, index: true, foreign_key: true
  #t.text :message
  #t.decimal :balance, scale: 2, precision: 6
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, length: { maximum: 50 },
    format: { with: VALID_EMAIL_REGEX }
  has_many :charges, dependent: :destroy
  belongs_to :account
  
end
