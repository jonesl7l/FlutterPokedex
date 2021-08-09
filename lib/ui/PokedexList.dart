import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/model/PokedexEntry.dart';
import 'package:test_app/ui/PokemonDetails.dart';
import 'package:test_app/util/StringExtension.dart';

class PokedexList extends StatefulWidget {
  final List<PokedexEntry>? entries;

  PokedexList({Key? key, @required this.entries}) : super(key: key);

  @override
  _pokedexListState createState() => _pokedexListState();
}

class _pokedexListState extends State<PokedexList> {

  //region ListView

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.entries!.length * 2,
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          return _buildRow(index, widget.entries![index]);
        });
  }

  Widget _buildRow(int index, PokedexEntry entry) {
    final pokemonName = ((entry.name != null) ? entry.name : "");
    return ListTile(
      title: Text("${(index + 1).toString()}. " +
          StringExtension(pokemonName.toString()).capitalise()),
      onTap: () {
        Navigator.of(context).push(_createRoute(entry.url!));
      },
    );
  }

  //endregion

  //region Navigation

  Route _createRoute(String url) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PokemonDetails(pokemonUrl: url),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.decelerate;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  //endregion
}
