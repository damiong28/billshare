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
  
  before_update :get_data_percentage, :get_data_share, :get_personal_total,
    :get_date
  
  validates :user_id, presence: true
  validates :surcharges, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :data_used, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
  belongs_to :bill
  belongs_to :user
  belongs_to :account
  
  private
  
    def get_data_percentage
      self.data_percentage = data_used / Bill.find(bill_id).total_data.to_d
    end
    
    def get_data_share
      self.data_share = data_percentage.to_d * Bill.find(bill_id).data_cost.to_d
    end
    
    def get_personal_total
      self.personal_total = data_share.to_d + surcharges.to_d
    end
    
    def get_date
      self.date = Bill.find(bill_id).date
    end
    
end
