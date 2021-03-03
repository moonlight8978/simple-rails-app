class RegistrationsController < ApplicationController
  unprotect_actions :new, :create

  def new
    @form = Forms::SignUp.new
  end

  def create
    @form = Forms::SignUp.new(sign_up_params)
    if @form.save
      Services::SendRegistrationMail.perform(@form.model)
      session[:user_id] = @form.model.id
      redirect_to root_path
    else
      render :new
    end
  end

  def sign_up_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email_notification_enabled, :email)
  end
end
