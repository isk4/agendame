class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :description, null: false
      t.datetime :start, null: false
      t.datetime :end
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
