import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/my_theme/custom_theme.dart';
import 'package:brew_crew/my_theme/my_theme.dart';
import 'package:brew_crew/pages/auth_page/sign_in_auth_page.dart';
import 'package:brew_crew/pages/home_page/home_page.dart';
import 'package:brew_crew/pages/wrapper_pages.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Firebase must be initialized after year 2021 when we use firebase in our project
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CustomTheme(initialThemeKey: MyThemeKeys.LIGHT, child: MyApp()));
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    debugShowCheckModeBanner = false,

    return StreamProvider<UserModel?>.value(
      catchError: (context, error) {},
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: CustomTheme.of(context),
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        home: WrapperPages(),
      ),
    );
  }
}
