class User < ActiveRecord::Base
  has_many :charges
  belongs_to :account
  
end
