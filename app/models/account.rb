class Account < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  has_many :bills, dependent: :destroy
  has_many :users, dependent: :destroy
  has_many :charges, dependent: :destroy
end
