Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/greet", to: "welcome#index"
  get "/greet/:name", to: "welcome#show"

  resources :pokemons
  # get "/pokemons", to: "pokemons#index"
  # get "/pokemons/:id", to: "pokemons#show"
  # post "/pokemons", to: "pokemons#create"
  # put "/pokemons/:id", to: "pokemons#update"
  # delete "/pokemons/:id", to: "pokemons#destroy"
end
