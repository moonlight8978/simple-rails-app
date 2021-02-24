Rails.application.routes.draw do
  root to: "home#index"

  resource :session, only: [], path: "" do
    get :new, path: 'sign_in', as: :new
    post :create, path: 'sign_in'
    delete :destroy, path: 'sign_in', as: :delete
  end

  resource :registration, only: [], path: "" do
    get :new, path: 'sign_up', as: :new
    post :create, path: 'sign_up'
  end
end
