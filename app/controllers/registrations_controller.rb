class RegistrationsController < ApplicationController
  unprotect_actions :new, :create

  def new
    @form = Forms::SignUp.new
  end

  def create
    @form = Forms::SignUp.new(sign_up_params)
    if @form.save
      session[:user_id] = @form.user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def sign_up_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email_notification_enabled, :email)
  end
end
