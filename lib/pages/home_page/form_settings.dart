import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/my_theme/custom_theme.dart';
import 'package:brew_crew/services/firestore_database_service.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../shared/constants.dart';

class FormSettingsHomePage extends StatefulWidget {
  const FormSettingsHomePage({Key? key}) : super(key: key);

  @override
  State<FormSettingsHomePage> createState() => _FormSettingsHomePageState();
}

class _FormSettingsHomePageState extends State<FormSettingsHomePage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5', '6', '7'];

  //formValues
  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  bool loading = false;
  bool updateButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);

    return StreamBuilder<UserModelData>(
        stream: FirestoreDatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModelData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Text(
                  'Update your brew data.',

                  style: TextStyle(
                      color: Colors.brown.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                  //style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData?.name,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Name",
                    icon: Icon(
                      Bootstrap.person,
                      color: Colors.brown[400],
                      size: 30.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.brown.shade400,
                        width: 2.0,
                      ),
                    ),
                    hintStyle: TextStyle(
                      //color: CustomTheme.of(context).primaryColor,
                      color: Colors.brown.shade400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                  style: TextStyle(
                    color: Colors.brown.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                //dropDown
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Sugar Quantity",
                    icon: Icon(
                      Bootstrap.plus_square,
                      color: Colors.brown[400],
                      size: 30.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: BorderSide(
                        color: Colors.brown.shade400,
                        width: 2.0,
                      ),
                    ),
                    hintStyle: TextStyle(
                      //color: CustomTheme.of(context).primaryColor,
                      color: Colors.brown.shade400,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //value: _currentSugars ?? userData?.sugar,
                  value: userData!.sugar,
                  items: sugars.map((e) {
                    return DropdownMenuItem(value: e, child: Text('$e sugars'));
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val!),

                  style: TextStyle(
                    color: Colors.brown.shade400,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //slider
                Slider(
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    activeColor:
                        //Colors.brown[_currentStrength ?? userData!.strength],
                        Colors.brown[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.brown[_currentStrength ?? userData.strength],
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    onChanged: (val) =>
                        setState(() => _currentStrength = val.round())),
                // ignore: deprecated_member_use

                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: CustomTheme.of(context).primaryColor,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() async {
                          await FirestoreDatabaseService(uid: user.uid)
                              .updateUserData(
                                  _currentSugars ?? userData.sugar,
                                  _currentName ?? userData.name,
                                  _currentStrength ?? userData.strength);

                          Navigator.pop(context);
                          updateButtonPressed = true;
                          loading = true;
                        });
                      }
                    },
                    child: Text(
                      "Update preferences",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ]),
            );
          } else {
            updateButtonPressed = false;
            loading = false;
            return Loading();
          }
        });
  }
}
