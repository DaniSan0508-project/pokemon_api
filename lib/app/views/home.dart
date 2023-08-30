import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokemon/app/views/detail_page.dart';
import 'package:pokemon/extensions/extensions.dart';
import 'package:pokemon/repositories/poke_repositories.dart';

import '../../models/poke_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MainState();
}

class _MainState extends State<Home> {
  final pokemonRepositories = PokemonRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quem é esse pokemon ?"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: FutureBuilder<List<PokeModel>>(
        future: pokemonRepositories.fetchPokemons(50),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(
              child: Text("Ocorreu um erro, tente novamente mais tarde."),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                final name = snapshot.data![index].name.capitalizeFirstLetter();
                final imageUrl = snapshot.data![index].imageUrl;
                return ListTile(
                  leading: Image.network(imageUrl),
                  title: Text(name, style: TextStyle(fontSize: 20)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailsPage(pokemonId: index)));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
