class CaptureService
  MAX_CAPTURED = 6

  # Inicializa el servicio de captura
  # Params:
  #   pokemon: Pokemon - El Pokémon que se intenta capturar
  def initialize(pokemon)
    @pokemon = pokemon
  end

  # Ejecuta el proceso de captura del Pokémon
  # Retorna: El Pokémon capturado
  def execute
    ActiveRecord::Base.transaction do
      release_oldest_if_necessary
      capture_pokemon
    end
    @pokemon
  end

  private

  # Libera al Pokémon capturado más antiguo si se ha alcanzado el límite de capturas
  # Efectos:
  #   - Si hay MAX_CAPTURED Pokémon capturados, libera al más antiguo
  #   - Actualiza el Pokémon liberado estableciendo captured: false y captured_at: nil
  def release_oldest_if_necessary
    captured_count = Pokemon.where(captured: true).count
    if captured_count >= MAX_CAPTURED
      oldest_captured = Pokemon.where(captured: true).order(:captured_at).first
      oldest_captured.update!(captured: false, captured_at: nil)
    end
  end

  # Captura el Pokémon actual
  # Efectos:
  #   - Actualiza el Pokémon estableciendo captured: true
  #   - Establece captured_at con la fecha y hora actual
  def capture_pokemon
    @pokemon.update!(captured: true, captured_at: Time.current)
  end
end