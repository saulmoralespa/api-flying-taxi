class CreateTableRides < ActiveRecord::Migration[7.1]
  def change
    create_table :rides do |t|
      t.references :riders, foreign_key: true
      t.references :drivers, foreign_key: true
      t.string  :start_location, array: true
      t.string  :end_location, array: true, null: true
      t.datetime  :start_time
      t.datetime  :end_time, null: true
      t.float :distance, default:0
      t.timestamps
    end
  end
end
