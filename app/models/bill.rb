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
  
  before_create :update_bill
  before_update :update_bill
  
  validates :amount, presence: true, 
    :numericality => { :greater_than_or_equal_to => 0, :less_than => 10000 }
  validates :total_data, presence: true, 
    :numericality => { :greater_than_or_equal_to => 0, :less_than => 1000 }
  validates :data_cost, presence: true, 
    :numericality => { :greater_than_or_equal_to => 0, :less_than => 10000 }
  
  belongs_to :account
  has_many :charges, dependent: :destroy
  
  private
  
  def update_bill
    data_subtotal = percent_total = data_share_total = 
    surcharges_total = subtotal = 0.0
    balance = self.amount
    if self.charges.present?
      self.charges.each do |charge|
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
    self.balance = balance
    self.data_subtotal = data_subtotal
    self.percent_total = percent_total
    self.data_share_total = data_share_total
    self.surcharges_total = surcharges_total
    self.subtotal = subtotal
  end
end
