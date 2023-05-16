import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/screens/login.dart';

import '../app_assets_constants/AppStrings.dart';
//import '../utils/AllData.dart';
import '../utils/appTools.dart';
import '../utils/styleConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onBackPressed() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
    return false;
  }

  _logout() {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      return;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: hexToColor("#121212"),
          title: Text(
            "Dashboard",
            style: kGoogleStyleTexts.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: hexToColor("#ffffff"),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
        drawer: Drawer(
          backgroundColor: hexToColor("#151515"),
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Hii there'),
              ),
              ListTile(
                  title: Text(
                    AppStrings.logoutButtonText,
                    style: kGoogleStyleTexts.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: hexToColor("#ffffff"),
                    ),
                  ),
                  onTap: _logout),
            ],
          ),
        ),
        backgroundColor: hexToColor("#121212"),
        body: SafeArea(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "SignIn Success 😊",
                      style: kGoogleStyleTexts.copyWith(
                          color: Colors.white, fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "UserId: ${auth.currentUser?.uid}",
                      style: kGoogleStyleTexts.copyWith(
                          color: Colors.white, fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Registered Phone Number: ${auth.currentUser?.phoneNumber}ind",
                      style: kGoogleStyleTexts.copyWith(
                          color: Colors.white, fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: _logout,
                      child: const Text(
                        "LogOut",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class _MyHomePageState extends State<HomeScreen> {
//   String _lastMessage = "";
//
//   _MyHomePageState() {
//     _messageStreamController.listen((message) {
//       setState(() {
//         if (message.notification != null) {
//           _lastMessage = 'Received a notification message:'
//               '\nTitle=${message.notification?.title},'
//               '\nBody=${message.notification?.body},'
//               '\nData=${message.data}';
//         } else {
//           _lastMessage = 'Received a data message: ${message.data}';
//         }
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Last message from Firebase Messaging:',
//                 style: Theme.of(context).textTheme.titleLarge),
//             Text(_lastMessage, style: Theme.of(context).textTheme.bodyLarge),
//           ],
//         ),
//       ),
//     );
//   }
// }
