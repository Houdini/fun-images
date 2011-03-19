class AuthenticationsController < Devise::OmniauthCallbacksController
  def facebook
    @facebook_data = env['omniauth.auth']
    @user = User.find_or_create_for_facebook_oauth @facebook_data
    if @user
      sign_in_and_redirect :user, @user
    end
  end

  def vkontakte
    @vk_data = env['omniauth.auth']
    @user = User.find_or_create_for_vkontakte_oauth @vk_data
    if @user
      sign_in_and_redirect :user, @user
    end
  end

  def twitter
    raise env['omniauth.auth'].inspect
  end
end