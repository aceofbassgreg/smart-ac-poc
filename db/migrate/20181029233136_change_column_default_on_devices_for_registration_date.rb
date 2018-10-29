class ChangeColumnDefaultOnDevicesForRegistrationDate < ActiveRecord::Migration[5.2]
  def change
    change_column_default :devices, :registration_date, Date.today
  end
end
