import 'package:flutter/material.dart';

import '../app_assets_constants/AppStrings.dart';
import '../utils/AllData.dart';
import '../utils/appTools.dart';
import '../utils/styleConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final auth = FirebaseAuth.instance;

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                    SizedBox(
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
                      child: Text(
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
