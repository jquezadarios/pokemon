require 'net/http'
require 'json'

class ImportService
  POKEMON_COUNT = 150
  BASE_URL = "https://pokeapi.co/api/v2/pokemon/"

  # Ejecuta el proceso de importación para los primeros POKEMON_COUNT Pokémon
  # Efecto: Importa los datos de cada Pokémon y los guarda en la base de datos
  def execute
    (1..POKEMON_COUNT).each do |id|
      import_pokemon(id)
    end
  end

  private

  # Importa un Pokémon individual por su ID
  # Params:
  #   id: Integer - El ID del Pokémon en la PokeAPI
  # Efecto: Obtiene los datos del Pokémon y lo crea en la base de datos
  def import_pokemon(id)
    data = fetch_pokemon_data(id)
    create_pokemon(data)
  end

  # Obtiene los datos de un Pokémon de la PokeAPI
  # Params:
  #   id: Integer - El ID del Pokémon en la PokeAPI
  # Retorna: Hash - Los datos del Pokémon en formato JSON parseado
  def fetch_pokemon_data(id)
    url = URI("#{BASE_URL}#{id}")
    response = Net::HTTP.get(url)
    JSON.parse(response)
  end

  # Crea un nuevo Pokémon en la base de datos con los datos proporcionados
  # Params:
  #   data: Hash - Los datos del Pokémon obtenidos de la PokeAPI
  # Efecto: Crea un nuevo registro de Pokémon en la base de datos
  def create_pokemon(data)
    Pokemon.create(
      name: data['name'],
      types: data['types'].map { |t| t['type']['name'] }.join(', '),
      image: data['sprites']['front_default'],
      captured: false
    )
  end
end