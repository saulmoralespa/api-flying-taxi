class CreateTableDrivers < ActiveRecord::Migration[7.1]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :location, array: true
      t.timestamps
    end
  end
end