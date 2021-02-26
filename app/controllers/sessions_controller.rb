class SessionsController < ApplicationController
  unprotect_actions :new, :create
  protect_actions :destroy

  def new
    @form = Forms::SignIn.new
  end

  def create
    @form = Forms::SignIn.new(sign_in_params)
    if @form.valid?
      session[:user_id] = @form.user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def sign_in_params
    params.require(:user).permit(:username, :password)
  end
end
