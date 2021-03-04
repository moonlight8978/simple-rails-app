class Csvs::Export::Rows::User < Csvs::ApplicationExportRow
  column :username, header: "Username", no: 1
  column :email_notification_enabled, header: "Notification enabled", format_with: :boolean, no: 2
  column :email, header: "Email", no: 3
end
