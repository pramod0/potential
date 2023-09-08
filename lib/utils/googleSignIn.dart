// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:potential/screens/tabspage.dart';
// import 'package:potential/utils/track.dart';
//
// import '../screens/CANcreationform/verifyMobileNo.dart';
// import '../screens/homeScreen.dart';
// import '../screens/login.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn googleSignIn = GoogleSignIn();
//
// String? name;
// String? email;
// String? imageUrl;
// String? mobileNumber;
//
// signInWithGoogle(BuildContext context) async {
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//   if (googleSignInAccount != null) {
//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;
//     final AuthCredential authCredential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken);
//
//     // Getting users credential
//     final UserCredential authResult =
//         await _auth.signInWithCredential(authCredential);
//     final User? user = authResult.user;
//
//     if (authResult != null) {
//       // if result not null we simply call the MaterialpageRoute,
//       // for go to the HomePage screen
//
//       if (user != null) {
//         // Checking if email and name is null
//         assert(user.email != null);
//         assert(user.displayName != null);
//         assert(user.photoURL != null);
//         // assert(user.phoneNumber != null);
//         name = user.displayName!;
//         email = user.email!;
//         imageUrl = user.photoURL!;
//         //mobileNumber = user.phoneNumber!;
//         //print(mobileNumber);
//
//         // Only taking the first part of the name, i.e., First Name
//         if (name!.contains(" ")) {
//           name = name?.substring(0, name?.indexOf(" "));
//         }
//
//         assert(!user.isAnonymous);
//
//         final User? currentUser = _auth.currentUser;
//         assert(user.uid == currentUser?.uid);
//
//         print('signInWithGoogle succeeded: $user');
//
//         Track.isMobileNoVerified
//             ? (Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => TabsPage(
//                     selectedIndex: 0,
//                   ),
//                 ),
//               ))
//             : (Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => VerifyMobileNum(),
//                 ),
//               ));
//
//         return '$user';
//       }
//
//       return null;
//     }
//   }
//
//   Future<void> signOutGoogle() async {
//     await googleSignIn.signOut();
//
//     print("User Signed Out");
//   }
// }
