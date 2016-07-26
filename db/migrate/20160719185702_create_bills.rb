class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.date :bill_date
      t.decimal :bill_amount, scale: 2, precision: 6
      t.float :total_data
      t.decimal :data_cost, scale: 2, precision: 6
      t.references :account, index: true, foreign_key: true
      t.float :data_overage

      t.timestamps null: false
    end
  end
end
