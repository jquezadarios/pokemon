class PokemonSerializer

    # Inicializa el serializador de Pokémon
    # Params:
    #   pokemon_or_pokemons: Pokemon - Un Pokémon individual o una colección de Pokémon
    # Efecto: Establece el objeto o colección a serializar
    def initialize(pokemon_or_pokemons)
      @pokemon_or_pokemons = pokemon_or_pokemons
    end
  
    # Serializa el Pokémon o la colección de Pokémon a formato JSON
    # Retorna: Hash - Datos serializados en formato JSON
    # Efecto: 
    #   - Determina si se trata de un Pokémon individual o una colección
    #   - Llama al método de serialización apropiado
    def serialized_json
      if @pokemon_or_pokemons.respond_to?(:each)
        serialize_collection
      else
        serialize_single(@pokemon_or_pokemons)
      end
    end
  
    private
  
    # Serializa una colección de Pokémon
    # Retorna: Hash - Datos serializados de la colección, incluyendo información de paginación
    # Efecto:
    #   - Serializa cada Pokémon en la colección
    #   - Incluye metadatos de paginación (página actual, total de páginas, total de Pokémon)
    def serialize_collection
      {
        pokemons: @pokemon_or_pokemons.map { |pokemon| serialize_single(pokemon) },
        page: @pokemon_or_pokemons.current_page,
        total_pages: @pokemon_or_pokemons.total_pages,
        total_count: Pokemon.count
      }
    end
  
    # Serializa un Pokémon individual
    # Params:
    #   pokemon: Pokemon - El Pokémon a serializar
    # Retorna: Hash - Datos serializados del Pokémon individual
    # Efecto: Convierte los atributos del Pokémon a un formato Hash
    def serialize_single(pokemon)
      {
        id: pokemon.id,
        name: pokemon.name,
        types: pokemon.types.split(', '),
        image: pokemon.image,
        captured: pokemon.captured,
        captured_at: pokemon.captured_at
      }
    end
  end