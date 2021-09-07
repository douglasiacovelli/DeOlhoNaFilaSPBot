Rails.application.routes.draw do
  post '/updates', to: 'updates#index'
end
