class Admin::BaseController < ApplicationController
  before_filter :authenticate_user
  before_filter -> { I18n.locale = 'en' }
  layout 'admin'
  # force_ssl if: :use_ssl?

  protected
    def authenticate_user
      redirect_to log_in_path unless current_user
    end
  
    def use_ssl?
      !Rails.env.test?
    end
end