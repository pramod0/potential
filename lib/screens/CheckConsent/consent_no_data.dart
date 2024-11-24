import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_assets_constants/AppColors.dart';
import '../../app_assets_constants/app_strings.dart';
import '../../models/investments.dart';
import '../../models/investor.dart';
import '../../utils/AllData.dart';
import '../../utils/styleConstants.dart';
import '../login.dart';
import '../profile_page.dart';

class ConsentNoData extends StatefulWidget {
  const ConsentNoData({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StateConsentNoData();
  }
}

class _StateConsentNoData extends State<ConsentNoData> {
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
          // irr: 0,
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
        // print(e.toString());
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
        // _logout();
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.appThemeColor, //"#121212"),
          title: Text(
            "Dashboard",
            style: kGoogleStyleTexts.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: AppColors.blackTextColor,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        drawer: Drawer(
          elevation: 0,
          backgroundColor: AppColors.appThemeColor,
          width: MediaQuery.of(context).size.width * 0.75,
          child: ListView(
            // Important: Remove any padding from the ListView.
            // itemExtent: 100,
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${AllData.investorData.firstName}",
                        style: kGoogleStyleTexts.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       "${AllData.investorData.firstName} ${AllData.investorData.lastName}",
                      //       style: kGoogleStyleTexts.copyWith(
                      //         color: AppColors.blackTextColor)
                      //             .withOpacity(0.87),
                      //         fontSize: 24.0,
                      //       ),
                      //       textAlign: TextAlign.start,
                      //     ),
                      //     Text(
                      //       "(${AllData.investorData.panCard})",
                      //       style: kGoogleStyleTexts.copyWith(
                      //         color: AppColors.blackTextColor)
                      //             .withOpacity(0.87),
                      //         fontSize: 15.0,
                      //       ),
                      //       textAlign: TextAlign.start,
                      //     ),
                      //   ],
                      // ),
                      Text(
                        "Last Fetch Time ${DateFormat('E, d MMM yyyy HH:mm:ss').format(AllData.lastFetchTime)}",
                        style: kGoogleStyleTexts.copyWith(
                          color: AppColors.blackTextColor.withOpacity(0.87),
                          fontSize: 12.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    tileColor: AppColors.appThemeColor,
                    leading: Icon(Icons.person_rounded),
                    title: Text(
                      "Profile",
                      style: kGoogleStyleTexts.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProfilePage())),
                    // onTap: _logout,
                  ),
                  //  Hide settings for now
                  // ListTile(
                  //   tileColor: AppColors.appThemeColor),
                  //   leading: Icon(Icons.settings_outlined),
                  //   title: Text(
                  //     AppStrings.settings,
                  //     style: kGoogleStyleTexts.copyWith(
                  //       fontWeight: FontWeight.w700,
                  //       fontSize: 20,
                  //       color: AppColors.blackTextColor),
                  //     ),
                  //   ),
                  //   onTap: () => Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //           builder: (context) => SettingsPage())),
                  // ),
                  ListTile(
                    tileColor: AppColors.appThemeColor,
                    leading: Icon(Icons.logout_outlined),
                    title: Text(
                      AppStrings.logout,
                      style: kGoogleStyleTexts.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                    onTap: _logout,
                  ),
                ],
              ),
              // Flex(direction: Axis.vertical, children: [SizedBox()]),
            ],
          ),
        ),
        backgroundColor: AppColors.appThemeColorAppBar,
        body: const Center(
          child: Text(
            """While we appreciate your consent, fetching all your transaction data may take up to a day. You can expect to see it by tomorrow.\nThank you for giving consent! Please note that retrieving all your transaction data can take up to 24 hours. You'll typically have access to it the next day.""",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
