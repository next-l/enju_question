Rails.application.routes.draw do
  resources :users do
    resources :questions do
      resources :answers
    end
    resources :answers
  end
  resources :questions
  resources :answers
end
