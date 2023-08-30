import 'package:dio/dio.dart';

import '../models/poke_model.dart';

class PokemonRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2/'));

  Future<PokeModel> fetchPokemon(int id) async{
    PokeModel selectedPokeById;
    try{
      Response response =  await _dio.get('pokemon/${id + 1}');
      PokeModel selectedPoke = PokeModel.fromJson(response.data);
      selectedPokeById = selectedPoke;
    } catch (e){
      throw Exception('Failed to load Pokemon data');
    }
    return selectedPokeById;
  }

  Future<List<PokeModel>> fetchPokemons(int count) async {
    List<PokeModel> pokemons = [];
    for(int i = 1; i<= count; i++){
      try {
        Response response = await _dio.get('pokemon/$i');
        PokeModel selectedPoke = PokeModel.fromJson(response.data);
        pokemons.add(selectedPoke);
      } catch (e) {
        throw Exception('Failed to load Pokemon data');
      }
    }
    return pokemons;
  }
}
