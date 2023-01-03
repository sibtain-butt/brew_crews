import 'package:brew_crew/models/brew_model.dart';
import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/pages/home_page/brew_list_home_page.dart';
import 'package:brew_crew/pages/home_page/fom_settings_home_page.dart';
import 'package:brew_crew/pages/home_page/form_settings.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/services/firestore_database_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModelData?>(context);

    // void _showSettingsPanel() {
    //   showModalBottomSheet(
    //       context: context,
    //       builder: (context) {
    //         return Container(
    //             padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
    //             child: Provider(
    //               create: (_) => UserModelData(uid: user!.uid),
    //               child: FormSettingsHomePage(),
    //             ));
    //       });
    // }
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'),
                  fit: BoxFit.contain,
                  //alignment: Alignment.center,
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
              child: FormSettingsHomePage(),
            );
          });
    }

    final AuthService _authService = AuthService();

    return StreamProvider<List<BrewModel?>>.value(
      value: FirestoreDatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            // Icon(Icons.person),
            TextButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
              //alignment: Alignment.center,
            ),
          ),
          child: BrewListHomePage(),
        ),
      ),
    );
  }
}
