class PasswordsController < ApplicationController
  def edit
    @form = Forms::ChangePassword.new(model: current_user)
  end

  def update
    @form = Forms::ChangePassword.new(model: current_user, **update_password_params)
    if @form.save
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def update_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
