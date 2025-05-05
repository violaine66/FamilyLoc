class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, if: :policy_scope_needed?

  private

  def skip_pundit?
    devise_controller? || is_a?(PagesController)
  end

  def policy_scope_needed?
    !skip_pundit? && action_name == 'index'
  end
end
