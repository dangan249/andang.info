Rails.application.routes.draw do

  mount_ember_app :frontend, to: "/"

  scope '/api' do
    get '/profile', to: 'linkedin_profile#show'
  end
end
