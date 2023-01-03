import 'package:brew_crew/models/login_user_model.dart';
import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/services/firestore_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceStylish {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _firebaseUser(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  // this code is used to convert Stream of firebaseUser (only user) to
  //UserModel class that we created but we need to make that
  //conversion code in service (classes).dart files
  // same conversion steps goes for the database firestore name as BrewModels class
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_firebaseUser);
  }

  Future signInAnonymous() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _firebaseUser(user);
    } catch (e) {
      return UserModel(code: e.toString(), uid: null);
    }
  }

  Future signInEmailPassword(LoginUser _login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _login.email.toString(),
              password: _login.password.toString());
      User? user = userCredential.user;
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return UserModel(code: e.code, uid: null);
    }
  }

  Future registerEmailPassword(LoginUser _login) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _login.email.toString(),
              password: _login.password.toString());
      User? user = userCredential.user;
      await FirestoreDatabaseService(uid: user!.uid)
          .updateUserData('0', 'Name', 100);
      return _firebaseUser(user);
    } on FirebaseAuthException catch (e) {
      return UserModel(code: e.code, uid: null);
    } catch (e) {
      return UserModel(code: e.toString(), uid: null);
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
