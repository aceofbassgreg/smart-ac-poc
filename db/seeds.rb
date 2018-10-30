# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
chars = ('A'..'Z').to_a + (1..9).to_a
dates = [Date.today, Date.yesterday, Date.yesterday - 1]
temperatures = (68..75).to_a
co2_values = (1..6).step(0.5).to_a
air_humidity_percentages = (50..65).step(0.5).to_a
device_health = ['Healthy', 'Not Too Healthy', 'OK']

30.times do 
  device = Device.create!(
    serial_number: chars.shuffle[0..14].join(''),
    registration_date: dates.sample,
    firmware_version: 1
  )
  10.times do
    device.sensor_readings.create(
      temperature: temperatures.sample,
      carbon_monoxide_level: co2_values.sample,
      air_humidity_percentage: air_humidity_percentages.sample,
      device_health: device_health.sample
    )
  end
end
