import 'package:brew_crew/models/brew_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'brew_list_home_page.dart';

class BrewTileHomePage extends StatelessWidget {
  //const BrewTileHomePage({Key? key, this.brew}) : super(key: key);
  final BrewModel? brew;
  BrewTileHomePage({this.brew});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 6.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew!.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(
            brew!.name,
            style: TextStyle(
              color: Colors.brown.shade400,
              fontWeight: FontWeight.w900,
            ),
          ),
          subtitle: Text(
            'Take ${brew!.sugar} sugar(s)',
            style: TextStyle(
              color: Colors.brown.shade400,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
