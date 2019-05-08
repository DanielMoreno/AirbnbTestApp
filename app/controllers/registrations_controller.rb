class RegistrationsController < Devise::RegistrationsController

  ## Specify allowed params for user registration
  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end