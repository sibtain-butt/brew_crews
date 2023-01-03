import 'package:brew_crew/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Create User object based on FirebaseUser
  //First User is a User class in models directory
  //Second User is from auth_service class in services directory

  //return user != null ? User(uid: user.uid) : null;

  // create MyUser object based on User (from Youtube.com theNetNinja.com Brew Crew App)
  // MyUser? _userfromFirebase(User user) {
  //   return user != null ? MyUser(uid: user.uid) : null;
  // }
  //
  UserModel? _userFromFirebaseUser(User user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  //AuthService change tha user stream
  //Firebase User is now User?
  //onAuthStateChanged is now authStateChanges()
  Stream<UserModel?> get user {
    return _firebaseAuth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // Stream<User> get user {
  //   return _firebaseAuth.onAuthStateChanged
  //       .map((User user) => _userFromFirebaseUser(user));
  // }

  //Sign-In Anonymously
  Future signInAnon() async {
    try {
      //UserCredential authResult = await _firebaseAuth.signInAnonymously();
      ///BREAKING: The FirebaseUser class has been renamed to *User*.
      ///BREAKING: The AuthResult class has been renamed to *UserCredential*

      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign-In with Email & Password
  Future signInWithEmailPassword(String email, String password) async {
    try {
      //UserCredential authResult = await _firebaseAuth.signInAnonymously();
      ///BREAKING: The FirebaseUser class has been renamed to *User*.
      ///BREAKING: The AuthResult class has been renamed to *UserCredential*

      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with Email & Password
  Future signUpWithEmailPassword(String email, String password) async {
    try {
      //UserCredential authResult = await _firebaseAuth.signInAnonymously();
      ///BREAKING: The FirebaseUser class has been renamed to *User*.
      ///BREAKING: The AuthResult class has been renamed to *UserCredential*

      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign-Out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
