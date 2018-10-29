class DevicesController < ApplicationController
  before_action :authenticate_user!

  def create
  end

  def show
  end

  def index
    @devices = Device.all
  end
end
