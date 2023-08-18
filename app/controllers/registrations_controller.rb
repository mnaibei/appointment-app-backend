class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: resource
    else
      render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
