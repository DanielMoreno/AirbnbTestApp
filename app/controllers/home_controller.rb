class HomeController < ApplicationController
	
## Swagger Documentation 
  swagger_controller :home, 'Home'

  swagger_api :show do
    summary "Default simple home page"
  end
#####################################################################################

  ## Default simple home page
  def top
  end
end
