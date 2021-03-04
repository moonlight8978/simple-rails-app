class SudosController < ApplicationController
  protect_actions :create

  def create
    @form = Forms::Sudo.new(**create_sudo_params, model: current_user)
    if @form.valid?
      # TODO: Validate return_to params?
      session[@form.session_key] = "-1"
      redirect_to @form.return_to || root_path
    else
      render :new
    end
  end

  private

  def create_sudo_params
    params.require(:user).permit(:password, :key, :return_to)
  end
end
