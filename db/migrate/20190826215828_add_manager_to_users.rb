class AddManagerToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :manager, index: true, foreign_key: true
  end
end
