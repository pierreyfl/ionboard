class AddAmountToCinfirm < ActiveRecord::Migration
  def change
    add_column :confirms, :amount, :integer
  end
end
