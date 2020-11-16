class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name,      null: false
      t.integer :duration, null: false

      t.timestamps
    end
  end
end
