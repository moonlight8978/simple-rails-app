class AddEmailNotificationToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email_notification_enabled, :boolean, default: false
    add_column :users, :email, :string
  end
end
