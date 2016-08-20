class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.date :date
      t.decimal :amount, precision: 6, scale: 2
      t.decimal :total_data, precision: 6, scale: 3
      t.decimal :data_cost, precision: 6, scale: 2 
      t.references :account, index: true, foreign_key: true, :null => false
      t.decimal :balance, precision: 6, scale: 2
      t.decimal :data_subtotal, precision: 6, scale: 3, default: 0
      t.decimal :percent_total, precision: 5, scale: 2, default: 0
      t.decimal :data_share_total, precision: 6, scale: 2, default: 0
      t.decimal :surcharges_total, precision: 6, scale: 2, default: 0
      t.decimal :subtotal, precision: 6, scale: 2, default: 0
      
      t.timestamps null: false
    end
  end
end
