Rails.application.routes.draw do
  get 'pages/page1'
  get 'pages/page2'
  root 'pages#page1'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
