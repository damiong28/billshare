class Charge < ActiveRecord::Base
  #t.references :bill, index: true, foreign_key: true
  #t.references :user, index: true, foreign_key: true
  #t.references :account, index: true, foreign_key: true, null: false
  #t.decimal :surcharges, precision: 6, scale: 2
  #t.decimal :data_used, precision: 6, scale: 3
  #t.decimal :data_percentage, precision: 4, scale: 2
  #t.decimal :data_share, precision: 6, scale: 2
  #t.decimal :personal_total, precision: 6, scale: 2
  #t.boolean :paid
  #t.date :date
  
  before_create :get_data_percentage, :get_data_share, :get_personal_total,
    :get_date
  after_create :set_user_balance, :update_bill
  
  before_update :get_data_percentage, :get_data_share, :get_personal_total,
    :get_date
  after_update :set_user_balance, :update_bill
  
  after_destroy :update_bill
    
  validates :user_id, presence: true
  validates :surcharges, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :data_used, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
  belongs_to :bill
  belongs_to :user
  belongs_to :account
  
  private
  
    def get_data_percentage
      self.data_percentage = data_used / bill.total_data.to_d
    end
    
    def get_data_share
      self.data_share = data_percentage.to_d * bill.data_cost.to_d
    end
    
    def get_personal_total
      self.personal_total = data_share.to_d + surcharges.to_d
    end
    
    def get_date
      self.date = bill.date
    end
    
    def set_user_balance
      balance = 0.00
      user.charges.each do |charge|
        unless charge.paid
          balance += charge.personal_total
        end
      end
      user.update_attributes(:balance => balance)
    end
    
  def update_bill
    data_subtotal = percent_total = data_share_total = 
    surcharges_total = subtotal = 0.0
    balance = bill.amount
    if bill.charges.present?
      bill.charges.each do |charge|
        data_subtotal += charge.data_used
        percent_total += charge.data_percentage
        data_share_total += charge.data_share
        surcharges_total += charge.surcharges
        subtotal += charge.personal_total
        if charge.paid
          balance -= charge.personal_total
        end
      end
      percent_total *= 100
    end
    bill.update_attributes(
      :balance => balance, :data_subtotal => data_subtotal,
      :percent_total => percent_total, :data_share_total => data_share_total,
      :surcharges_total => surcharges_total, :subtotal => subtotal)
  end
    
end
