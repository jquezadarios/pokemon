Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :pokemons, only: [:index] do
        collection do
          get 'captured', to: 'pokemons#captured'
          post 'import', to: 'pokemons#import'
        end
        member do
          post 'capture', to: 'pokemons#capture'
          delete 'release', to: 'pokemons#release'
        end
      end
    end
  end
end
