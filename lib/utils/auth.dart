// import 'dart:convert';
// import 'dart:async';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class HttpException implements Exception {
//   final String message;
//   HttpException(this.message);
//
//   @override
//   String toString() {
//     return message;
//   }
// }
//
// class Auth with ChangeNotifier {
//   String? _token;
//   DateTime? _expiryDate;
//   String? _userId;
//   Timer? _authTimer;
//   bool _isGoogleSignin = false;
//
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   bool get isAuth {
//     return token != null;
//   }
//
//   String? get token {
//     if ((_expiryDate != null &&
//             _expiryDate!.isAfter(DateTime.now()) &&
//             _token != null) ||
//         (_isGoogleSignin && _token != null)) {
//       return _token;
//     }
//     return null;
//   }
//
//   String? get userId {
//     return _userId;
//   }
//
//   Future<void> resetPassword(String email) async {
//     await _firebaseAuth.sendPasswordResetEmail(email: email);
//   }
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn googleSignIn = new GoogleSignIn();
//   DatabaseReference dbRef =
//       FirebaseDatabase.instance.reference().child("Users");
//
//   Future<String?> getCurrentUID() async {
//     return (_firebaseAuth.currentUser)?.uid;
//   }
//
//   getProfileImage() {
//     String? photoURL = _firebaseAuth!.currentUser?.photoURL;
//     if (_firebaseAuth.currentUser?.photoURL != null) {
//       return Image.network(
//         photoURL!,
//       );
//     } else {
//       return const Icon(Icons.account_circle, size: 100);
//     }
//   }
//
//   Future getCurrentUser() async {
//     return _firebaseAuth.currentUser;
//   }
//
//   Future<String?> signInWithGoogle() async {
//     await Firebase.initializeApp();
//     _isGoogleSignin = true;
//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();
//     final GoogleSignInAuthentication? googleSignInAuthentication =
//         await googleSignInAccount?.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleSignInAuthentication?.accessToken,
//       idToken: googleSignInAuthentication?.idToken,
//     );
//
//     final UserCredential authResult =
//         await _auth.signInWithCredential(credential);
//     final User? user = authResult.user;
//
//     if (user != null) {
//       assert(!user.isAnonymous);
//       assert(await user.getIdToken() != null);
//
//       final User? currentUser = _auth.currentUser;
//       assert(user.uid == currentUser?.uid);
//
//       print('signInWithGoogle succeeded: $user');
//       _userId = user.uid;
//       _token = await user.getIdToken();
//       print(_userId);
//       print(_token);
//       print('$isAuth');
//       return '$user';
//     }
//
//     return null;
//   }
//
//   Future<void> signOutGoogle() async {
//     await googleSignIn.signOut();
//
//     print("User Signed Out");
//   }
//
//   Future<void> _authentication(
//       String email, String password, urlSegment) async {
//     final url =
//         'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$loginkey';
//     var Url = Uri.parse(url);
//     final response = await http.post(
//       Url,
//       body: json.encode(
//         {'email': email, 'password': password, 'returnSecureToken': true},
//       ),
//     );
//     final responseData = json.decode(response.body);
//     print(responseData);
//     _token = responseData['idToken'];
//     _userId = responseData['localId'];
//     _expiryDate = DateTime.now().add(
//       Duration(
//         seconds: int.parse(
//           responseData['expiresIn'],
//         ),
//       ),
//     );
//     _autoLogout();
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     final userData = json.encode(
//       {
//         'token': _token,
//         'userId': _userId,
//         'expiryDate': _expiryDate?.toIso8601String()
//       },
//     );
//     prefs.setString('userData', userData);
//     if (responseData['error'] != null) {
//       throw HttpException(responseData['error']['message']);
//     }
//   }
//
//   Future<void> signup(String email, String password) async {
//     return _authentication(email, password, 'signUp');
//   }
//
//   Future<void> singin(String email, String password) async {
//     return _authentication(email, password, 'signInWithPassword');
//   }
//
//   Future<bool> tryautoLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (!prefs.containsKey('userData')) {
//       return false;
//     }
//     final extractedUserData =
//         json.decode(prefs.getString('userData')!) as Map<String, Object>;
//     final expiryDate =
//         DateTime.parse(extractedUserData['expiryDate'].toString());
//     if (expiryDate.isBefore(DateTime.now())) {
//       return false;
//     }
//     _token = extractedUserData['token'].toString();
//     _userId = extractedUserData['userId'].toString();
//     _expiryDate = expiryDate;
//     notifyListeners();
//     _autoLogout();
//     return true;
//   }
//
//   Future<void> logout() async {
//     _token = null;
//     _userId = null;
//     _expiryDate = null;
//     if (_authTimer != null) {
//       _authTimer!.cancel();
//       _authTimer = null;
//     }
//     print('logged out');
//     notifyListeners();
//     final prefs = await SharedPreferences.getInstance();
//     prefs.clear();
//   }
//
//   void _autoLogout() {
//     _authTimer?.cancel();
//     final timeToExpire = _expiryDate?.difference(DateTime.now()).inSeconds;
//     _authTimer = Timer(Duration(seconds: timeToExpire!), logout);
//   }
// }
