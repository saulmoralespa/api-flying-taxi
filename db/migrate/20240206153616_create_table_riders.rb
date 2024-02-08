class CreateTableRiders < ActiveRecord::Migration[7.1]
  def change
    create_table :riders do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.timestamps
    end
  end
end
