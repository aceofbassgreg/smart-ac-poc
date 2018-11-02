class AddApiAccessTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :api_access_token, :string
    add_index :users, :api_access_token, unique: true
  end
end
