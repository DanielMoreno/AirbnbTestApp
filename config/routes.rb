Rails.application.routes.draw do
  
  ## Base homepage
  get "/" => "home#top"
  
  ## User Auth and registration paths
  devise_for :users,
  				:path => '',
  			 	:path_names => {:sign_in => 'login', :sign_out => 'logout'},
  			 	:controllers => {:registrations => 'registrations'}

  ## Room and Room's Bookings routes
  get 'rooms/search' => 'rooms#search'
  resources :rooms do
    put :contract_agreement
    put :publish
  end
  resources :room do
    get 'bookings' => 'bookings#room_index'
    resources :bookings , only: [:create, :show, :destroy, :update]
  end

  ## User Bookings
  resources :bookings , only: [:index]

  ## Swagger Documentation
  mount GrapeSwaggerRails::Engine => "/swagger"
end
