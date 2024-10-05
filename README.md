# README

rutas importantes:

controlador de pokemons
pokemon_api/app/controllers/api/v1/pokemons_controller.rb

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
