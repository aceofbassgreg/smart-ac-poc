class AddUniquenessConstraintToSerialNumberOnDevice < ActiveRecord::Migration[5.2]
  def change
    remove_index :devices, :serial_number
    add_index :devices, :serial_number, unique: true
  end
end
