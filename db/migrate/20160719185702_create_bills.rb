class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.date :date
      t.decimal :amount, scale: 2, precision: 6
      t.float :total_data
      t.decimal :data_cost, scale: 2, precision: 6
      t.references :account, index: true, foreign_key: true, :null => false
      t.decimal :balance, scale: 2, precision: 6
      
      t.timestamps null: false
    end
  end
end
