Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

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

  resource :profile, only: [:edit, :update]

  resource :password, only: [:edit, :update]

  resource :notification_settings, only: [:edit, :update]

  resource :sudo, only: [:create]
end
