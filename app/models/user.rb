class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_secure_token :api_access_token

  def api_authentication_key
    Base64.urlsafe_encode64("#{email}:#{api_access_token}")
  end
end
