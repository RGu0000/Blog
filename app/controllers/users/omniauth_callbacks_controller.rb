# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def sign_in_with(provider_name)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider_name
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join('\n')
    end
  end

  def google_oauth2
    sign_in_with 'Google'
  end

  def facebook
    sign_in_with 'Facebook'
  end

  def failure
    redirect_to root_path
  end
end
