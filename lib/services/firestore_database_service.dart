import 'package:brew_crew/models/brew_model.dart';
import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/pages/home_page/brew_list_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart';
import 'package:provider/provider.dart';

class FirestoreDatabaseService {
  //Collection reference like database connectivity
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brew');

  final String? uid;

  FirestoreDatabaseService({required this.uid});

  ///we need 2 times UpdateUserData function first when we need
  ///to create database with new user sign up button clicked
  ///and second when user chaged the preferences of brews like
  ///sugar, strength and name
  ///IMPORTANT NOTE: remember we can not write below updateUserData function
  ///to createUserData because it will be created with dummy data with the
  ///firebase auth new account create time when sign up button clicked

  Future updateUserData(String sugar, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugar': sugar,
      'name': name,
      'strength': strength,
    });
  }

  // this code is used to convert Stream of firebaseUser (only user) to
  //UserModel class that we created but we need to make that
  //conversion code in service (classes).dart files
  // same conversion steps goes for the database firestore name as BrewModels class
  //not same but concept is same and steps are bit different
  //--------------------------------------------------------------
  //BrewList from snapshot
  List<BrewModel> _brewListFromSnapshot(QuerySnapshot querySnapshot) {
    try {
      return querySnapshot.docs.map((doc) {
        return BrewModel(
            // sugars: doc.get('sugars') ?? '0',
            // strength: doc.get('strength') ?? 0,
            // name: doc.get('name') ?? '');
            sugar:
                doc.data().toString().contains('sugar') ? doc.get('sugar') : '',
            strength: doc.data().toString().contains('strength')
                ? doc.get('strength')
                : '',
            name:
                doc.data().toString().contains('name') ? doc.get('name') : '');
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //user data(UserModelData) from snapshots
  UserModelData _userModelDataFromSnapshot(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data =
        documentSnapshot.data()! as Map<String, dynamic>;
    // documentSnapshot.data()! as Map<String, dynamic>;
    return UserModelData(
        // uid: uid.toString(),
        // name: documentSnapshot.get('name'),
        // strength: documentSnapshot.get('strength'),
        // sugars: documentSnapshot.get('sugars'));
        uid: uid.toString(),
        name: data['name'] ?? 'Name',
        sugar: data['sugar'] ?? '0',
        strength: data['strength'] ?? 100);
    // we can write in 3 ways
    //1st way
    //name: documentSnapshot['name'],
    //2nd way
    //name: documentSnapshot.get('name')
    // uid: uid.toString(),
    // sugars: documentSnapshot.data().toString().contains('sugar')
    //     ? documentSnapshot.get('sugar')
    //     : '',
    // strength: documentSnapshot.data().toString().contains('strength')
    //     ? documentSnapshot.get('strength')
    //     : '',
    // name: documentSnapshot.data().toString().contains('name')
    //     ? documentSnapshot.get('name')
    //     : '');
  }

  //to get brew Streams we need to pass stream using QuerySnapshot
  // Stream<QuerySnapshot?> get brews {
  //   return brewCollection.snapshots();
  // }
  Stream<List<BrewModel?>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //we dont want to work with a DocumentSnapshot
  //we want to work with our custom UserModelData Object based on our UserModelData
  //get user doc stream
  //get user doc stream from firestore and use it to preloaded the
  //bottomSheetWidget
  //Stream<DocumentSnapshot> get userData {
  Stream<UserModelData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userModelDataFromSnapshot);
  }
}
