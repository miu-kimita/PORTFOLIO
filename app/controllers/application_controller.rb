class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

    def set_locale　　　　　##この部分は多言語化に使用
        I18n.locale = locale
    end

    def locale
        @locale ||= params[:locale] ||= I18n.default_locale
    end

    def default_url_options(options={})
        options.merge(locale: locale)
    end


  def after_sign_in_path_for(resource)
    case resource
      when PostUser
        post_users_my_page_path
      when Admin
        admin_root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :post_user
        new_post_user_session_path
    elsif resource == :admin
        new_admin_session_path
    else
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :nickname, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  private
  def configure_permitted_parameters  # メールアドレス以外の自分で追加したカラムを許可
   devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end