require 'test_helper'

class SensorReadingsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sensor_readings_create_url
    assert_response :success
  end

  test "should get index" do
    get sensor_readings_index_url
    assert_response :success
  end

  test "should get show" do
    get sensor_readings_show_url
    assert_response :success
  end

end
