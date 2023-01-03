// import 'package:brew_crew/models/user_model.dart';
// import 'package:brew_crew/my_theme/custom_theme.dart';
// import 'package:brew_crew/services/firestore_database_service.dart';
// import 'package:brew_crew/shared/loading.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class FormSettingsHomePage extends StatefulWidget {
//   const FormSettingsHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<FormSettingsHomePage> createState() => _FormSettingsHomePageState();
// }
//
// class _FormSettingsHomePageState extends State<FormSettingsHomePage> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> sugars = ['0', '1', '2', '3', '4', '5', '6'];
//
//   //Form values
//   String? _currentName;
//   String? _currentSugars;
//   int? _currentStrength;
//   final _nameController = TextEditingController();
//
//   late UserModelData userModelData;
//
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserModel>(context);
//
//     final nameTextFormField = TextFormField(
//       initialValue: userModelData.name,
//       controller: _nameController,
//       autofocus: false,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter a name.';
//         } else {
//           return null;
//         }
//       },
//       onChanged: (value) {
//         setState(() {
//           _currentName = value;
//         });
//       },
//
//       ///Below single line details is in shared/constant.dart file
//       ///with InputDecoration annotation type like Data Type
//       decoration: InputDecoration(
//         contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         hintText: "Name",
//         icon: Icon(
//           Icons.abc,
//           color: Colors.brown[400],
//           size: 30.0,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(32.0),
//         ),
//         fillColor: Colors.white,
//         filled: true,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(32.0),
//           borderSide: BorderSide(
//             color: Colors.white,
//             width: 2.0,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(32.0),
//           borderSide: BorderSide(
//             color: Colors.brown.shade400,
//             width: 2.0,
//           ),
//         ),
//         hintStyle: TextStyle(
//           //color: CustomTheme.of(context).primaryColor,
//           color: Colors.brown.shade400,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       style: TextStyle(
//         color: Colors.brown.shade400,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//
//     final updateMaterialButton = Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(30.0),
//       color: CustomTheme.of(context).primaryColor,
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width,
//         padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         onPressed: () async {
//           // if (_formKey.currentState!.validate()) {
//           //   setState(() {
//           //     signInButtonPressed = true;
//           //     loading = true;
//           //   });
//           //   dynamic result = await _auth.signInEmailPassword(
//           //       LoginUser(email: _email.text, password: _password.text));
//           //   if (result.uid == null) {
//           //     //null means unsuccessfull authentication
//           //     showDialog(
//           //         context: context,
//           //         builder: (context) {
//           //           return AlertDialog(
//           //             content: Text(result.code),
//           //           );
//           //         });
//           //     setState(() {
//           //       signInButtonPressed = false;
//           //       loading = false;
//           //     });
//           //   }
//           // }
//         },
//         child: Text(
//           "Update Preference",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//
//     final dropDownButtonFormField = DropdownButtonFormField<String?>(
//       //value: _currentSugars ?? '0',
//       //for preloaded the values that's why we do userModelData!.sugars
//       value: _currentSugars ?? userModelData!.sugars,
//
//       items: sugars.map((sugar) {
//         return DropdownMenuItem(
//           value: sugar,
//           child: Text('$sugar sugars'),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           _currentSugars = value!;
//         });
//       },
//     );
//
//     final sliderButtonFormField = Slider(
//       min: 100,
//       max: 900,
//       //?? double question mark mean if null value in current strength
//       // the value is 100 otherwise currentStrength value would be 200 to 900
//       value: (_currentStrength ?? userModelData.strength).toDouble(),
//       activeColor:
//           Colors.brown[_currentStrength ?? userModelData.strength as int],
//       //inactiveColor: Colors.brown[_currentStrength ?? 100],
//       //_currentStrength ?? userData?.strength as int
//       inactiveColor:
//           Colors.brown[_currentStrength ?? userModelData.strength as int],
//       divisions: 8,
//       onChanged: (value) {
//         setState(() {
//           _currentStrength = value.round();
//         });
//       },
//     );
//
//     return SafeArea(
//       child: StreamBuilder<UserModelData>(
//           stream: FirestoreDatabaseService(uid: user.uid).userData,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               //UserModelData? userModelData = snapshot.data;
//               //
//               userModelData = snapshot.data!;
//               return Form(
//                 key: _formKey,
//                 child: Column(
//                   children: [
//                     Text(
//                       'Update your brew settings.',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                     SizedBox(height: 20.0),
//                     nameTextFormField,
//                     SizedBox(height: 20.0),
//                     updateMaterialButton,
//                     SizedBox(height: 20.0),
//                     //dropdown
//                     dropDownButtonFormField,
//                     SizedBox(height: 20.0),
//                     //slider
//                     sliderButtonFormField,
//                   ],
//                 ),
//               );
//             } else {
//               return Loading();
//             }
//           }),
//     );
//   }
// }
