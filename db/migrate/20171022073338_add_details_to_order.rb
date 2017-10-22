class AddDetailsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :email, :string
    add_column :orders, :order_number, :string
  end
end
