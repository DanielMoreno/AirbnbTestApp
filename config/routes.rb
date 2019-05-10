Rails.application.routes.draw do
  ## User Auth and registration paths
  devise_for :users,
  				:path => '',
  			 	:path_names => {:sign_in => 'login', :sign_out => 'logout'},
  			 	:controllers => {:registrations => 'registrations'}

  ## Room and Room's Bookings routes
  get 'rooms/search' => 'rooms#search'
  resources :rooms
  resources :room do
    resources :bookings , only: [:create, :show]
  end

  ## User Bookings
  resources :bookings , only: [:index]

  ## Base homepage
  get "/" => "home#top"
end
