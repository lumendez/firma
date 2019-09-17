class ApplicationController < ActionController::Base
  protect_from_forgery
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def after_sign_in_path_for(resource)
    constancia_documentos_path
  end

  private

  def user_not_authorized
    flash[:alert] = "No está autorizado para esta acción."
    redirect_to(request.referrer || constancia_documentos_path)
  end

end
