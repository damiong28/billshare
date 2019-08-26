class AddManagerToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :manager, index: true
    add_foreign_key :users, column: :manager_id
  end
end
