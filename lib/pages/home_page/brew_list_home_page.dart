import 'package:brew_crew/models/brew_model.dart';
import 'package:brew_crew/pages/home_page/brew_tile_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrewListHomePage extends StatefulWidget {
  const BrewListHomePage({Key? key, sugars, strength, name}) : super(key: key);

  @override
  State<BrewListHomePage> createState() => _BrewListHomePageState();
}

class _BrewListHomePageState extends State<BrewListHomePage> {
  @override
  Widget build(BuildContext context) {
    //instead of using <QuerySnapshot?> we will
    //use our own list List<BrewList?>
    //final brews = Provider.of<QuerySnapshot>(context);
    // both statements are below comment one and below final brew = ...
    final brews = Provider.of<List<BrewModel?>?>(context) ?? [];

    // final brew = Provider.of<List<BrewModel?>?>(context);
    // first if statement is correct to check the brew documents in total
    // if (brews != null) {
    //   brews.forEach((brew) {
    //     print('this is fucking brews');
    //     print(brew!.name);
    //     print(brew.sugar);
    //     print(brew.strength);
    //   });
    // }
    // print(brews);
    // brews.forEach((brewElement) {
    //   print('this is brews data');
    //   print(brewElement.strength);
    //   print(brewElement.name);
    //   print(brewElement.sugar);
    // });
    // for (var doc in brews.docs) {
    //   print(doc.data());
    // }
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTileHomePage(brew: brews[index]);
      },
    );
  }
}
