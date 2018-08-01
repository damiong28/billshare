class ReduceDataPercentageOnCharges < ActiveRecord::Migration
  def up
    change_column :charges, :data_percentage, :decimal, :precision => 6, :scale => 4
  end
  def down 
  end
end

