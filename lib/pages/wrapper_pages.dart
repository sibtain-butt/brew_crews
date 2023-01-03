import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/pages/auth_page/auth_page.dart';
import 'package:brew_crew/pages/auth_page/sign_in_auth_page.dart';
import 'package:brew_crew/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperPages extends StatelessWidget {
  const WrapperPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return either HomePage() or AuthPage Widget.

    final userModel = Provider.of<UserModel?>(context);
    // print(userModel);
    if (userModel == null) {
      //AuthPage means handler filter the authenticated user to either go to
      //login page if already login or if new user then got to Signup
      return AuthPage();
    } else {
      return HomePage();
    }
  }
}
