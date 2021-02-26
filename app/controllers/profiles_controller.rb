class ProfilesController < ApplicationController
  protect_actions :edit, :update

  def edit
    # TODO: Refactor attribute assignment logic
    @form = Forms::EditProfile.new(username: current_user.username, model: current_user)
  end

  def update
    @form = Forms::EditProfile.new(**update_profile_params, model: current_user)
    if @form.save
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def update_profile_params
    params.require(:user).permit(:username, :avatar)
  end
end
