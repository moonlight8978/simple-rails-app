class NotificationSettingsController < ApplicationController
  sudo_authen_actions :edit, :update, key: "#{name}/edit"

  def edit
    @form = Forms::ChangeNotificationSettings.new(
      email: current_user.email,
      email_notification_enabled: current_user.email_notification_enabled,
      model: current_user
    )
  end

  def update
    @form = Forms::ChangeNotificationSettings.new(
      **change_notification_settings_params,
      model: current_user
    )
    if @form.save
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def change_notification_settings_params
    params.require(:user).permit(:email, :email_notification_enabled)
  end
end
