import 'package:brew_crew/pages/auth_page/sign_in_auth_page.dart';
import 'package:brew_crew/pages/auth_page/sign_in_stylish.dart';
import 'package:brew_crew/pages/auth_page/sign_up_auth_page.dart';
import 'package:brew_crew/pages/auth_page/sign_up_stylish.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showSignIn = true;
  //remove only void from {void toggleView Function}
  //void toggleView(){
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
