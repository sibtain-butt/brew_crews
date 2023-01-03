import 'package:brew_crew/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpAuthPage extends StatefulWidget {
  //const SignUpAuthPage({Key? key, this.toggleView}) : super(key: key);
  final Function toggleView;
  SignUpAuthPage({required this.toggleView});

  @override
  State<SignUpAuthPage> createState() => _SignUpAuthPageState();

  //final toggleView;
}

class _SignUpAuthPageState extends State<SignUpAuthPage> {
  final AuthService _authService = AuthService();
  //final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = '';

  var error = '';
  dynamic signUpResult;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign-up to Brew Crew'),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(0.0),
              backgroundColor: MaterialStatePropertyAll(
                Colors.brown[400],
              ),
            ),
            icon: Icon(
              Icons.person,
            ),
            label: Text(
              'Sign-in',
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: (value) => value!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val.trim();
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                obscureText: true,
                autofocus: true,
                validator: (value) =>
                    value!.length < 6 ? 'Password must be 6+ chars long' : null,
                onChanged: (val) {
                  setState(() {
                    password = val.trim();
                  });
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.pink[400]),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // print('email is $email');
                    // print('password is $password');
                    //Add await like below
                    //dynamic signUpResult = await _authService

                    signUpResult =
                        _authService.signUpWithEmailPassword(email, password);
                  }
                  if (signUpResult == null) {
                    setState(() {
                      error = 'Provide a valid email';
                    });
                  }
                },
                child: Text(
                  'Sign-up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15.0,
                ),
              )
            ],
          ),
        ),

        // child: ElevatedButton(
        //   onPressed: () async {
        //     //AuthResult changed to UserCredential
        //     dynamic userCredential = await _authService.signInAnon();
        //     if (userCredential == null) {
        //       print('Error Sign-In');
        //     } else {
        //       print('Sign-In Successfully');
        //       print(userCredential.uid);
        //     }
        //   },
        //   child: Text(
        //     'Sigh-In Annonymously',
        //   ),
        // ),
      ),
    );
  }
}
