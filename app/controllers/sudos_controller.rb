class SudosController < ApplicationController
  def new
    @form = Forms::Sudo.new
  end

  def create
    @form = Forms::Sudo.new(**create_sudo_params, model: current_user)
    if @form.valid?
      # TODO: Validate return_to params?
      session[@form.session_key] = "-1"
      redirect_to params.dig(:user, :return_to) || root_path
    else
      render :new
    end
  end

  private

  def create_sudo_params
    params.require(:user).permit(:password, :key)
  end
end
