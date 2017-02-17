Rails.application.routes.draw do

  scope '/api' do
    get '/profile', to: 'linkedin_profile#show'
  end
end
