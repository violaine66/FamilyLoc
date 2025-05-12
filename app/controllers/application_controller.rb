class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  after_action :verify_authorized, if: -> { !skip_pundit? && action_name != 'index' }
  after_action :verify_policy_scoped, if: -> { !skip_pundit? && action_name == 'index' }

  private

  def skip_pundit?
    devise_controller? || is_a?(PagesController)
  end
end
