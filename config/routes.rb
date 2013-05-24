MemoriesRubykr::Application.routes.draw do
  root 'photos#index'

  resources :photos do
    member do
      post 'like' => "likes#create", :as => :like
      delete 'like' => "likes#destroy", :as => :unlike
    end
  end

  post '/login' => redirect('/auth/facebook'), :as => :login
  delete "/logout" => "users#destroy", :as => :logout

  get "/auth/:provider/callback" => "users#create"
  get "/auth/failure" => "users#failure"
end
