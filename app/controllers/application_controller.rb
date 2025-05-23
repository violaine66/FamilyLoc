class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit::Authorization

  after_action :verify_authorized, if: -> { !skip_pundit? && action_name != 'index' }
  after_action :verify_policy_scoped, if: -> { !skip_pundit? && action_name == 'index' }

  def after_sign_in_path_for(resource)
    proprietes_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nom_complet])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nom_complet])
  end

  private

  def skip_pundit?
    devise_controller? || is_a?(PagesController)
  end
end
