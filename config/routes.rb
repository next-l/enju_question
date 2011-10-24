Rails.application.routes.draw do
  resources :users do
    resources :questions, :only => :index
    resources :answers, :only => :index
  end
  resources :questions do
    resources :answers, :only => :index 
  end
  resources :answers
end
