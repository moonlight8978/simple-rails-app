class ApplicationController < ActionController::Base
  unless Rails.env.development?
    rescue_from StandardError, with: :handle_unexpected_error
    rescue_from ApplicationError, with: :handle_application_error
  end

  helper_method :current_user
  helper_method :user_signed_in?

  class << self
    def protect_actions(*actions)
      before_action -> { raise Errors::Auth::Unauthenticated unless user_signed_in? }, only: actions
    end

    def unprotect_actions(*actions)
      before_action -> { raise Errors::Auth::Unauthorized if user_signed_in? }, only: actions
    end

    def requires_password(*actions, key: nil)
      before_action -> { raise Errors::Auth::Unauthenticated unless user_signed_in? }, only: actions
      before_action -> {
        form = Forms::Sudo.new(key: key || "#{controller_name}/#{action_name}")
        unless session[form.session_key]
          @form = form
          render "sudos/new"
        end
      }, only: actions
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) || Guest.new
  end

  def user_signed_in?
    !current_user.guest?
  end

  private

  def handle_application_error(error)
    render file: "public/#{error.status}.html", status: error.status, layout: false
  end

  def handle_unexpected_error(error)
    Rails.logger.info(error.message)
    Rails.logger.info(error.backtrace.join("\n"))
    render file: "public/500.html", status: :internal_server_error, layout: false
  end
end
