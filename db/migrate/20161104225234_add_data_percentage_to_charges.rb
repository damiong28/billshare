class AddDataPercentageToCharges < ActiveRecord::Migration
  def change
    change_column :charges, :data_percentage, :decimal, :precision => 6, :scale => 4
  end
end
