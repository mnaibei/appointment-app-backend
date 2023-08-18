class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    render json: resource
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
