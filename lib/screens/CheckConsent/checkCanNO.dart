import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/app_assets_constants/AppStrings.dart';
import 'package:potential/utils/appTools.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/investments.dart';
import '../../models/investor.dart';
import '../../utils/AllData.dart';
import '../../utils/styleConstants.dart';
import '../login.dart';

class CheckCANNO extends StatefulWidget {
  const CheckCANNO({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StateCheckCANNO();
  }
}

class _StateCheckCANNO extends State<CheckCANNO> {
  _logout() async {
    try {
      //FirebaseAuth.instance.signOut();
      SharedPreferences inst = await SharedPreferences.getInstance();
      inst.clear();
      AllData.investedData = InvestedData(
          invested: 0,
          current: 0,
          totalReturns: 0,
          absReturns: 0,
          xirr: 0,
          irr: 0,
          sinceDaysCAGR: 0,
          fundData: []);
      AllData.schemeMap.clear();
      AllData.investorData = User();
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) async {
        if (canPop) {
          return;
        }
        _logout();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              hexToColor(AppColors.appThemeColor), //hexToColor("#121212"),
          title: Text(
            "Dashboard",
            style: kGoogleStyleTexts.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: hexToColor(AppColors.blackTextColor),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        drawer: Drawer(
          backgroundColor: hexToColor(AppColors.appThemeColor),
          width: MediaQuery.of(context).size.width * 0.45,
          child: ListView(
            // Important: Remove any padding from the ListView.
            // itemExtent: 100,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: hexToColor(AppColors.currentValue),
                ),
                child: Text(
                  "Hii, there...",
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: hexToColor(AppColors.blackTextColor),
                  ),
                ),
              ),
              ListTile(
                  tileColor: hexToColor(AppColors.red),
                  title: Text(
                    AppStrings.logoutButtonText,
                    style: kGoogleStyleTexts.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: hexToColor(AppColors.whiteTextColor),
                    ),
                  ),
                  onTap: _logout),
            ],
          ),
        ),
        backgroundColor: hexToColor(AppColors.appThemeColorAppBar),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              AppStrings.pleaseRegisterText,
              style: kGoogleStyleTexts.copyWith(
                  color: hexToColor(
                      AppColors.blackTextColor), //hexToColor("#ffffff"),
                  fontSize: 15,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
