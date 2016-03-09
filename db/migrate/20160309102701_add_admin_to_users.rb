class AddAdminToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin, :boolean, default: false
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
  end
end
