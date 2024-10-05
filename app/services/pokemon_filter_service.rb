class PokemonFilterService
  # Inicializa el servicio de filtrado de Pokémon
  # Params:
  #   pokemons: ActiveRecord::Relation - La colección inicial de Pokémon
  #   filter_params: Hash - Parámetros de filtrado (name y type)
  # Efecto: Establece la colección inicial y los parámetros de filtrado
  def initialize(pokemons, filter_params)
    @pokemons = pokemons
    @filter_params = filter_params || {}
  end

  # Aplica los filtros a la colección de Pokémon
  # Retorna: ActiveRecord::Relation - La colección de Pokémon filtrada
  # Efecto: Aplica secuencialmente los filtros por nombre y tipo
  def filter
    filter_by_name
    filter_by_type
    @pokemons
  end

  private

  # Filtra la colección de Pokémon por nombre
  # Efecto: 
  #   - Si se proporciona un nombre en filter_params, filtra los Pokémon cuyo nombre 
  #     contenga la cadena proporcionada (insensible a mayúsculas/minúsculas)
  #   - No hace nada si no se proporciona un nombre
  def filter_by_name
    return unless @filter_params[:name].present?
    @pokemons = @pokemons.where("LOWER(name) LIKE ?", "%#{@filter_params[:name].downcase}%")
  end

  # Filtra la colección de Pokémon por tipo
  # Efecto:
  #   - Si se proporciona un tipo en filter_params, filtra los Pokémon cuyo campo 'types' 
  #     contenga el tipo proporcionado (insensible a mayúsculas/minúsculas)
  #   - No hace nada si no se proporciona un tipo
  def filter_by_type
    return unless @filter_params[:type].present?
    @pokemons = @pokemons.where("LOWER(types) LIKE ?", "%#{@filter_params[:type].downcase}%")
  end
end