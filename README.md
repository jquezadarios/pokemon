# Pokemon

Rutas importantes:

controlador de pokemons

app/controllers/api/v1/pokemons_controller.rb

Para listar todos los Pokémons:
```
curl -X GET "http://localhost:3000/api/v1/pokemons?page=1&name=char&type=fire"
```

Para capturar un Pokémon :
```
curl -X POST "http://localhost:3000/api/v1/pokemons/1/capture"
```

Para listar Pokémon capturados:
```
curl "http://localhost:3000/api/v1/pokemons/captured"
```

Para liberar un Pokémon capturado:
```
curl -X DELETE "http://localhost:3000/api/v1/pokemons/1/destroy"
```

Para importar los 150 primeros Pokémons:
```
curl -X POST "http://localhost:3000/api/v1/pokemons/import"
```

Servicios importantes:

app/services/capture_service.rb

app/services/import_service.rb

app/services/pagination_service.rb

app/services/pokemon_filter_service.rb

app/services/pokemon_serializer.rb

app/services/release_service.rb