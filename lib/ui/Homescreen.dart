import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:test_app/model/ApiResponse.dart';
import 'package:test_app/model/PokedexEntry.dart';
import 'package:test_app/viewmodel/MainViewModel.dart';

import 'PokedexList.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _inputController = TextEditingController();
  String? _searchText;

  @override
  void initState() {
    _inputController.addListener(
      () {
        setState(() {
          _searchText = _inputController.text;
        });
      },
    );
    super.initState();
    Provider.of<MainViewModel>(context, listen: false)
        .fetchPokedexData("pokemon?limit=151");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(tag: "appBar", child: Text('Pokedex')),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor.withAlpha(50),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextField(
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                        ),
                        controller: _inputController,
                        onChanged: (value) {
                          Provider.of<MainViewModel>(context, listen: false)
                              .searchList(value);
                        },
                        onSubmitted: (value) {},
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.red,
                          ),
                          hintText: 'Enter Pokemon Name or Number',
                        )),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: getPokedexWidget(context)),
        ],
      ),
    );
  }

  Widget getPokedexWidget(BuildContext context) {
    ApiResponse apiResponse = Provider.of<MainViewModel>(context).response;
    final entries = apiResponse.data as List<PokedexEntry>?;
    switch (apiResponse.status) {
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
      case Status.COMPLETED:
        return PokedexList(entries: entries);
      case Status.ERROR:
        return Center(
          child: Text('Please try again later!'),
        );
      case Status.INITIAL:
      default:
        return Center(
          child: Text('Search the Pokedex by name or number'),
        );
    }
  }
}
