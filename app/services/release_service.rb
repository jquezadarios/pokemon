class ReleaseService
  # Inicializa el servicio de liberación de Pokémon
  # Params:
  #   pokemon: Pokemon - El Pokémon que se va a liberar
  def initialize(pokemon)
    @pokemon = pokemon
  end

  # Ejecuta el proceso de liberación del Pokémon
  # Retorna: Boolean - true si la actualización fue exitosa, false en caso contrario
  # Efecto: 
  #   - Actualiza el Pokémon estableciendo captured a false
  #   - Establece captured_at a nil, eliminando la fecha de captura
  def execute
    @pokemon.update(captured: false, captured_at: nil)
  end
end