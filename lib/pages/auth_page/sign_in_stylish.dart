import 'package:brew_crew/my_theme/custom_theme.dart';
import 'package:brew_crew/services/auth_stylish.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:brew_crew/shared/wave_loading_shared.dart';
import 'package:flutter/material.dart';

import '../../models/login_user_model.dart';

class Login extends StatefulWidget {
  final Function? toggleView;

  Login({this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

class _Login extends State<Login> {
  bool _obscureText = true;

  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthServiceStylish _auth = AuthServiceStylish();
  bool loading = false;
  bool wave_loading_shared = false;

  bool signInAnonButtonPressed = false;
  bool signInButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      controller: _email,
      autofocus: false,
      validator: (value) {
        if (value != null) {
          if (value.contains('@') && value.endsWith('.com')) {
            return null;
          }
          return 'Enter a Valid Email Address';
        }
      },

      ///Below single line details is in shared/constant.dart file
      ///with InputDecoration annotation type like Data Type
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        icon: Icon(
          Icons.email,
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
      style: TextStyle(
        color: Colors.brown.shade400,
        fontWeight: FontWeight.bold,
      ),
    );

    final passwordField = TextFormField(
      obscureText: _obscureText,
      controller: _password,
      autofocus: false,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'This field is required';
        }
        if (value.trim().length < 8) {
          return 'Password must be at least 8 characters in length';
        }
        // Return null if the entered password is valid
        return null;
      },
      style: TextStyle(
        color: Colors.brown.shade400,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
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
            color: CustomTheme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        hintStyle: TextStyle(
            color: CustomTheme.of(context).primaryColor,
            fontWeight: FontWeight.bold),
        icon: Icon(
          Icons.password,
          color: Colors.brown.shade400,
          size: 30.0,
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
          color: CustomTheme.of(context).primaryColor,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
    );

    final txtbutton = TextButton(
      onPressed: () {
        widget.toggleView!();
      },
      child: const Text(
        'Don\'t have an account? Sign up',
        style: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final loginAnonymousButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: CustomTheme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          setState(() {
            signInAnonButtonPressed = true;
            // loading = true;
            wave_loading_shared = true;
          });
          dynamic result = await _auth.signInAnonymous();

          if (result.uid == null) {
            //null means unsuccessfull authentication
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(result.code),
                  );
                });
            setState(() {
              //loading = false;
              signInAnonButtonPressed = false;
              wave_loading_shared = false;
            });
          }
        },
        child: const Text(
          "Sign in as Guest Account",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final loginEmailPasswordButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: CustomTheme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              signInButtonPressed = true;
              loading = true;
            });
            dynamic result = await _auth.signInEmailPassword(
                LoginUser(email: _email.text, password: _password.text));
            if (result.uid == null) {
              //null means unsuccessfull authentication
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(result.code),
                    );
                  });
              setState(() {
                signInButtonPressed = false;
                loading = false;
              });
            }
          }
        },
        child: Text(
          "Sign in",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
    if (wave_loading_shared) {
      return WaveLoadingShared();
    } else if (loading) {
      return Loading();
    } else {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              'Sign in to Brew Crew',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: CustomTheme.of(context).primaryColor,
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
                //alignment: Alignment.center,
              ),
            ),
            //color: CustomTheme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        loginAnonymousButon,
                        const SizedBox(height: 45.0),
                        emailField,
                        const SizedBox(height: 25.0),
                        passwordField,
                        txtbutton,
                        const SizedBox(height: 35.0),
                        loginEmailPasswordButton,
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
