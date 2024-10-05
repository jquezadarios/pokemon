module Api
    module V1
      class PokemonsController < ApplicationController
        before_action :set_pokemon, only: [:capture, :release]

        # GET /api/v1/pokemons
        # Lista todos los Pokémon con filtros opcionales y paginación
        def index
          pokemons = PokemonFilterService.new(Pokemon.all, filter_params).filter
          paginated_pokemons = PaginationService.new(pokemons, page_params).paginate
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
          params.permit(:name, :type)
        end

        # Permite solo los parámetros de paginación específicos
        def page_params
          params.permit(:page, :per_page)
        end
      end
    end
  end
