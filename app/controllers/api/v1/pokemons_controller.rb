module Api
  module V1
    class PokemonsController < ApplicationController
      before_action :set_pokemon, only: [:capture, :release]

      # GET /api/v1/pokemons
      def index
        pokemons = Pokemon.all
        pokemons = PokemonFilterService.new(pokemons, filter_params).filter
        paginated_pokemons = pokemons.page(page_params[:page]).per(page_params[:per_page])
        render json: PokemonSerializer.new(paginated_pokemons).serialized_json
      end

        # POST /api/v1/pokemons/:id/capture
        # Captura un Pokémon específico
        def capture
          CaptureService.new(@pokemon).execute
          render json: PokemonSerializer.new(@pokemon).serialized_json
        end

        # GET /api/v1/pokemons/captured
        # Lista todos los Pokémon capturados con paginación
        def captured
          captured_pokemons = Pokemon.captured.page(params[:page]).per(params[:per_page] || 10)
          render json: PokemonSerializer.new(captured_pokemons).serialized_json
        end

        # DELETE /api/v1/pokemons/:id/release
        # Libera un Pokémon capturado
        def release
          ReleaseService.new(@pokemon).execute
          render json: PokemonSerializer.new(@pokemon).serialized_json
        end

        # POST /api/v1/pokemons/import
        # Importa los primeros 150 Pokémon desde la PokeAPI
        def import
          ImportService.new.execute
          render json: { message: 'Import completed successfully' }, status: :ok
        end

        private

        # Encuentra el Pokémon por ID y lo asigna a @pokemon
        def set_pokemon
          @pokemon = Pokemon.find(params[:id])
        end

        # Permite solo los parámetros de filtro específicos
        def filter_params
          params.slice(:name, :type)
        end

        # Permite solo los parámetros de paginación específicos
        def page_params
          {
            page: params[:page] || 1,
            per_page: params[:per_page] || 10
          }
        end
      end
    end
  end
