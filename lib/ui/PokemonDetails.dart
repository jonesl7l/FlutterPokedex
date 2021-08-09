import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/ApiResponse.dart';
import 'package:test_app/model/Pokemon.dart';
import 'package:test_app/util/StringExtension.dart';
import 'package:test_app/viewmodel/MainViewModel.dart';

class PokemonDetails extends StatefulWidget {
  final String pokemonUrl;

  PokemonDetails({Key? key, required this.pokemonUrl}) : super(key: key);

  @override
  _pokemonDetailsState createState() => _pokemonDetailsState();
}

class _pokemonDetailsState extends State<PokemonDetails> {
  final TextStyle _style = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w800,
    fontFamily: 'Roboto',
    letterSpacing: 0.5,
    fontSize: 20,
  );

  @override
  void initState() {
    super.initState();
    Provider.of<MainViewModel>(context, listen: false)
        .fetchPokemonData(widget.pokemonUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: Hero(tag: "appBar", child: Text('Pokedex')),
        ),
        body: getProductDetailsWidget());
  }

  Widget getProductDetailsWidget() {
    ApiResponse apiResponse =
        Provider.of<MainViewModel>(context).pokemonResponse;
    Pokemon? pokemon = apiResponse.data as Pokemon?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        var typeString =
            StringExtension(pokemon!.types!.first.name!).capitalise();

        if (pokemon.types!.length > 1) {
          typeString +=
              ", ${StringExtension(pokemon.types!.last.name!).capitalise()}";
        }

        return Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        height: 300,
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: pokemon
                              .sprites!.other!.officialArtwork!.frontDefault!,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                          "Name: ${StringExtension(pokemon.name!).capitalise()}",
                          style: _style)),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Number: ${pokemon.id!}", style: _style)),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Type(s): $typeString", style: _style)),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Height: ${pokemon.height! / 10}m",
                          style: _style)),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text("Weight: ${pokemon.weight! / 10}kg",
                          style: _style))
                ]));
      case Status.ERROR:
        return Center(
          child: Text('Please try again later!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text('Please try again later!'),
        );
    }
  }
}
