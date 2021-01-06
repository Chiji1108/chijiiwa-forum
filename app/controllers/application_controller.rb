class ApplicationController < ActionController::Base
  # before_action do
  #   I18n.locale = :ja
  # end
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    # deviseのpermitted_parameterを追加する
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :username] )
      devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :username] )
    end
end
