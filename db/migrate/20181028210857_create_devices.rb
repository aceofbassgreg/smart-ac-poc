class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :serial_number, null: false
      t.datetime :registration_date, null: false
      t.string :firmware_version, null: false

      t.timestamps
    end
  end
end
