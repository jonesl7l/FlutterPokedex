import 'package:flutter/cupertino.dart';
import 'package:test_app/data/PokeRepository.dart';
import 'package:test_app/model/ApiResponse.dart';
import 'package:test_app/model/PokedexEntry.dart';
import 'package:test_app/model/Pokemon.dart';

class MainViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.loading('Fetching pokemon data');
  ApiResponse _pokemonApiResponse = ApiResponse.loading(
      'Fetching pokemon data');

  List<Pokemon> _pokemon = [];
  late List<PokedexEntry> _pokedexEntries;
  late Pokemon _selectedPokemon;

  ApiResponse get response {
    return _apiResponse;
  }

  ApiResponse get pokemonResponse {
    return _pokemonApiResponse;
  }

  List<Pokemon> get pokemon {
    return _pokemon;
  }

  Pokemon get selectedPokemon {
    return _selectedPokemon;
  }

  List<PokedexEntry> get pokedexEntries {
    return _pokedexEntries;
  }

  /// Call the pokemon service and gets the data of requested pokemon data of
  /// an artist.
  Future<void> fetchPokedexData(String value) async {
    try {
      _pokedexEntries = await PokeRepository().fetchPokedex(value);
      _apiResponse = ApiResponse.completed(pokedexEntries);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  /// Call the pokemon service and gets the data of requested pokemon data of
  /// an artist.
  Future<void> fetchPokemonData(String value) async {
    try {
      Pokemon pokemon = await PokeRepository().fetchPokemon(value);
      _pokemonApiResponse = ApiResponse.completed(pokemon);
    } catch (e) {
      _pokemonApiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    notifyListeners();
  }

  /// Call the pokemon service and gets the data of requested pokemon data of
  /// an artist.
  searchList(String value) async {
    final filteredList = value.isNotEmpty ? pokedexEntries.where((i) => i.name!.toLowerCase().contains(value.toLowerCase()))
        .toList() : pokedexEntries;
    _apiResponse = ApiResponse.completed(filteredList);
    notifyListeners();
  }

  void setSelectedPokemon(Pokemon pokemon) {
    _selectedPokemon = pokemon;
    notifyListeners();
  }
}