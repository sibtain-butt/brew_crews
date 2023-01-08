import 'package:brew_crew/models/login_user_model.dart';
import 'package:brew_crew/my_theme/custom_theme.dart';
import 'package:brew_crew/services/auth_stylish.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function? toggleView;
  Register({this.toggleView});

  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

class _Register extends State<Register> {
  bool _obscureText = true;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthServiceStylish _auth = AuthServiceStylish();
  bool loading = false;

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
          return 'Email must be valid and without spaces';
        }
      },
      style: TextStyle(
        color: Colors.brown.shade400,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        // prefixIcon: Icon(
        //   Icons.alternate_email,
        //   color: CustomTheme.of(context).primaryColor,
        // ),
        // prefixText: AutofillHints.email,
        hintText: "Email",
        icon: Icon(
          Icons.email,
          color: CustomTheme.of(context).primaryColor,
          size: 30.0,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        //fillColor: Colors.brown.shade50,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: const BorderSide(
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
          fontWeight: FontWeight.bold,
        ),
      ),
      enableSuggestions: true,
      //textAlign: TextAlign.center,
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
          return 'Password must be at least 8 characters long';
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
          color: CustomTheme.of(context).primaryColor,
          size: 30.0,
        ),
        suffixIcon: IconButton(
          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
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
        'Already have an account? Log in',
        style: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: CustomTheme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            dynamic result = await _auth.registerEmailPassword(
              LoginUser(
                email: _email.text,
                password: _password.text,
              ),
            );
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
                loading = false;
              });
            }
          }
        },
        child: const Text(
          "Sign up",
          style: TextStyle(
            //color: CustomTheme.of(context).backgroundColor),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );

    if (loading) {
      return Loading();
    } else {
      return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text(
              'Sign up to Brew Crew',
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
            // color: CustomTheme.of(context).backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  // autovalidateMode: AutovalidateMode.always,
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 45.0),
                        emailField,
                        const SizedBox(height: 25.0),
                        passwordField,
                        //const SizedBox(height: 25.0),
                        txtbutton,
                        const SizedBox(height: 35.0),
                        registerButton,
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
