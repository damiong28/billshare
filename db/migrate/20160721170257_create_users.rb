class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.references :account, index: true, foreign_key: true
      t.text :message
      t.decimal :balance, scale: 2, precision: 6

      t.timestamps null: false
    end
  end
end
