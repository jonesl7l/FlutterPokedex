import 'dart:convert';

import 'package:test_app/model/PokedexEntry.dart';
import 'package:test_app/model/Pokemon.dart';
import 'package:test_app/networking/PokeService.dart';

class PokeRepository {
  PokeService _pokeService = PokeService();

  Future<List<PokedexEntry>> fetchPokedex(String value) async {
    dynamic response = await _pokeService.getBase(value);
    final jsonData = response['results'] as List;
    List<PokedexEntry> pokedexEntries =
        jsonData.map((tagJson) => PokedexEntry.fromJson(tagJson)).toList();
    return pokedexEntries;
  }

  Future<Pokemon> fetchPokemon(String value) async {
    dynamic response = await _pokeService.get(value);
    Pokemon pokemon = Pokemon.fromJson(response);
    return pokemon;
  }
}
