class Users::SessionsController < Devise::SessionsController
  respond_to :json
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    render json: { data: current_user, message: 'Logged in successfully' } if user_signed_in?
  rescue StandardError
    render json: { error: 'Invalid email or password' }, status: :unauthorized
  end

  def current
    render json: { logged_in: user_signed_in? }
  end

  def destroy
    sign_out(resource_name)
    render json: { message: 'Signed out successfully' }
  end

  private

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
