class CreateConfirms < ActiveRecord::Migration
  def change
    create_table :confirms do |t|
      t.string :name
      t.string :email
      t.string :address
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
