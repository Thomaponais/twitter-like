class AddDbValidationInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :crypted_password, :string, null: false
    change_column :users, :username, :string, null: false
  end
end
