module ApplicationHelper
  
  def self.authenticate!(env, params, error_callback)
    return if env['warden'].authenticated?
    return if User.find_by_authentication_token(params[:access_token])
    error_callback.call
  end
  
  def self.authenticate_as_admin!(env, params, error_callback)
    current_user = env['warden'].try(:user) || User.find_by_authentication_token(params[:access_token])
    error_callback.call if current_user.blank? || !current_user.try(:admin)
  end
  
end
