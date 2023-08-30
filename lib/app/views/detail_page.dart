import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/components/colors_poke_types.dart';
import 'package:pokemon/extensions/extensions.dart';

import '../../models/poke_model.dart';
import '../../repositories/poke_repositories.dart';

class DetailsPage extends StatelessWidget {
  final int pokemonId;
  final PokemonRepository pokemonRepository = PokemonRepository();

  DetailsPage({Key? key, required this.pokemonId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Pokémon"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: FutureBuilder<PokeModel>(
        future: pokemonRepository.fetchPokemon(pokemonId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
              child: Text("Ocorreu um erro, tente novamente mais tarde."),
            );
          } else {
            final name = snapshot.data!.name.capitalizeFirstLetter();
            final imageUrl = snapshot.data!.imageUrl;
            final types = snapshot.data!.types.join(", ");

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color:
                        typeColors[snapshot.data!.types.first] ?? Colors.grey,
                    elevation: 5,
                    child: Image.network(imageUrl, width: 400.0,),
                  ),
                  SizedBox(height: 20),
                  Text(name, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text(
                    "Tipo(s): $types",
                    style: TextStyle(
                        fontSize: 16,
                        color: typeColors[snapshot.data!.types.first] ??
                            Colors.white),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
