class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.references :account, index: true, foreign_key: true
      t.text :message
      t.decimal :balance, precision: 6, scale: 2, default: 0.00

      t.timestamps null: false
    end
  end
end
