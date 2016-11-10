class AdjustDataPercentageOnCharges < ActiveRecord::Migration
  def change
    change_column :charges, :data_percentage, :decimal, :precision => 7, :scale => 5
  end
end
