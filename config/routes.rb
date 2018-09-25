Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'currency#show'

  post 'convert' => 'currency#convert'
end
