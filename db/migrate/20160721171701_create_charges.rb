class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :bill, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true, null: false
      t.decimal :surcharges, precision: 6, scale: 2
      t.decimal :data_used, precision: 6, scale: 3
      t.decimal :data_percentage, precision: 4, scale: 2
      t.decimal :data_share, precision: 6, scale: 2
      t.decimal :personal_total, precision: 6, scale: 2
      t.boolean :paid
      
      t.timestamps null: false
    end
  end
end