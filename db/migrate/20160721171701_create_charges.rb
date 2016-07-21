class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :bill, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.decimal :surcharges, precision: 6, scale: 2
      t.decimal :data_used, precision: 6, scale: 2

      t.timestamps null: false
    end
  end
end
