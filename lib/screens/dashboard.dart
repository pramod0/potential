import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/models/token.dart';
import 'package:potential/screens/graph_page.dart';
import 'package:potential/screens/profile_page.dart';
import 'package:potential/screens/schemeSummaryScreen.dart';
import 'package:potential/utils/elevated_expaned.dart';
// import 'package:potential/screens/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../app_assets_constants/app_strings.dart';
import '../models/investments.dart';
import '../models/investor.dart';
import '../models/schemes.dart';
import '../utils/AllData.dart';
import '../utils/appTools.dart';
import '../utils/exit_dialogue.dart';
import '../utils/networkUtil.dart';
import '../utils/styleConstants.dart';
import 'login.dart';

final oCcy = NumberFormat("#,##,##0.00", "en_US"); //changed from #,##0.00

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String sortFeature = "Current";
  String srt = '0';

  // #TODO if this is not used then we should remove it :Pramod
  showModalClass(Color color) async {
    var banner = MaterialBanner(
        content: Text(
          "Error! You will need to ",
          style: kGoogleStyleTexts.copyWith(
              color: hexToColor(AppColors.whiteTextColor), fontSize: 15),
        ),
        leading: Icon(
          Icons.info,
          color: hexToColor(AppColors.whiteTextColor),
        ),
        backgroundColor: color,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              color: Colors.red.shade300,
              child: AutoSizeText(
                "re-login",
                style: kGoogleStyleTexts.copyWith(
                    color: hexToColor(AppColors.whiteTextColor), fontSize: 15),
              ),
            ),
          ),
        ]);
    await ScaffoldMessenger.of(context).showMaterialBanner(banner);
    await Future.delayed(const Duration(milliseconds: 500));
    ScaffoldMessenger.of(context).clearMaterialBanners();
  }

  showMaterialBanner(Color color) async {
    SharedPreferences inst = await SharedPreferences.getInstance();
    inst.clear();
    var banner = MaterialBanner(
      backgroundColor: color,
      leading: Icon(
        Icons.info,
        color: hexToColor(AppColors.whiteTextColor),
      ),
      content: InkWell(
        onTap: () async {
          if (!context.mounted) return;
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginPage()));
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
        child: AutoSizeText.rich(
          const TextSpan(text: "Please ", children: <TextSpan>[
            TextSpan(
              text: 're-login',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.underline),
            )
          ]),
          style: kGoogleStyleTexts.copyWith(
              color: hexToColor(AppColors.whiteTextColor), fontSize: 15),
        ),
      ),
      actions: [Container()],

      // actions: [
      //   InkWell(
      //     onTap: () {
      //       Navigator.of(context).pushReplacement(
      //           MaterialPageRoute(builder: (context) => const LoginPage()));
      //       ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      //     },
      //     child: Container(
      //       decoration: BoxDecoration(
      //           color: Colors.red.shade300,
      //           borderRadius: const BorderRadius.all(Radius.circular(1.5))),
      //       padding: const EdgeInsets.all(3),
      //       child: AutoSizeText(
      //         "relogin",
      //         style: kGoogleStyleTexts.copyWith(
      //             color: hexToColor(AppColors.whiteTextColor), fontSize: 15),
      //       ),
      //     ),
      //   ),
      //
      // ]
    );
    await ScaffoldMessenger.of(context).showMaterialBanner(banner);
    await Future.delayed(const Duration(milliseconds: 800));
    ScaffoldMessenger.of(context).clearMaterialBanners();
  }

  showSnackBar(String text, Color color) {
    var snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.endToStart,
        content: AutoSizeText(
          text,
          style: kGoogleStyleTexts.copyWith(
            color: color,
            fontSize: 15,
          ),
        ));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<String> getData() async {
    // if (AllData.investedData.sinceDaysCAGR > 0) {
    //   if (kDebugMode) {
    //     print("Api call saved here!!!");
    //   }
    //   return Future.value("Data Downloaded Successfully");
    // }

    SystemChannels.textInput.invokeMethod('TextInput.hide');
    bool connectionResult = await NetWorkUtil().checkInternetConnection();
    if (!connectionResult) {
      showSnackBar("No Internet Connection", Colors.red);
      return Future.value("No Internet");
    }
    try {
      var token = Token.instance.token;
      var responseBody;
      try {
        responseBody =
            jsonDecode(await ApiService().dashboardAPI(token, 10, 0));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        // var schemes = "No";
        // showSnackBar("Session expired or in use elsewhere.",
        //     hexToColor(AppColors.redAccent));
        // Future.delayed(const Duration(seconds: 1)).whenComplete(
        //     () => showMaterialBanner(hexToColor(AppColors.redAccent)));
        // await EasyLoading.dismiss();

        // In case of exception return to Login screen

        SharedPreferences inst = await SharedPreferences.getInstance();
        inst.clear();
        if (!context.mounted) {
          return Future.value(
              "No Data"); // This is written just to avoid error in the next line.
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
        return Future.value("No Data");
      }

      InvestedData investedData = InvestedData.fromJson(responseBody['data']);
      await EasyLoading.dismiss();
      if (kDebugMode) {
        print("responseBody.toString()");
      }

      var prefs = SharedPreferences.getInstance();
      prefs.then((pref) =>
          pref.setString('investedData', jsonEncode(responseBody['data'])));
      AllData.setInvestmentData(investedData);
      setState(() {
        showSnackBar(
            "Data Updated Successfully", hexToColor(AppColors.whiteTextColor));
      });
      return Future.value("Data Downloaded Successfully");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      // var schemes = "No";
      // showSnackBar("Session expired or in use elsewhere.",
      //     hexToColor(AppColors.redAccent));
      // Future.delayed(const Duration(seconds: 1)).whenComplete(
      //     () => showMaterialBanner(hexToColor(AppColors.redAccent)));
      // await EasyLoading.dismiss();

      // In case of exception return to Login screen

      SharedPreferences inst = await SharedPreferences.getInstance();
      inst.clear();
      if (!context.mounted) {
        return Future.value(
            "No Data"); // This is written just to avoid error in the next line.
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      return Future.value("No Data");
    }
  }

  Future<String> getSchemeData(String fund, String scheme) async {
    bool connectionResult = await NetWorkUtil().checkInternetConnection();
    if (!connectionResult) {
      showSnackBar("No Internet Connection", Colors.red);
      return Future.value("No Internet");
    }
    try {
      EasyLoading.show(
        status: 'Please wait your data is loading...',
      );
      if (AllData.schemeMap.containsKey('${fund}_$scheme')) {
        await EasyLoading.dismiss();
        return '${fund}_${scheme.toString()}';
      }
      var token = Token.instance.token;
      var responseBody =
          jsonDecode(await ApiService().schemeSummaryAPI(token, fund, scheme));
      SchemeData schemeData = SchemeData.fromJson(responseBody['fundData']);
      AllData.setSchemeSummary(schemeData);

      var prefs = SharedPreferences.getInstance();
      prefs.then((pref) =>
          pref.setString('allSchemes', jsonEncode(AllData.schemeMap)));
      await EasyLoading.dismiss();

      return '${fund}_${scheme.toString()}';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      // var schemes = "No";
      showSnackBar("Session expired or in use elsewhere.",
          hexToColor(AppColors.redAccent));
      showMaterialBanner(hexToColor(AppColors.redAccent));
      await EasyLoading.dismiss();
      return Future.value("No Data");
    }
  }

  @override
  void initState() {
    getData().whenComplete(() {
      WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    });
    super.initState();
  }

  _logout() async {
    try {
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
      try {
        ApiService().logoutAPI(Token.instance.token);
      } catch (e) {
        print("$e, No problem it will be handled when used gets in again");
      }
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

  Future<bool> _onBackPressed() async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const ExitDialogue());
    return false;
    // return false;
  }

  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        await getData();
      },
      color: hexToColor(AppColors.loginBtnColor),
      child: PopScope(
        canPop: false, //make false when Onpop
        onPopInvoked: (canPop) async {
          if (canPop) {
            return;
          }
          await _onBackPressed();
        },
        child: SafeArea(
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
              elevation: 0,
              backgroundColor: hexToColor(AppColors.appThemeColor),
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
                              wordSpacing: 1,
                              fontSize: 20,
                              color: hexToColor(AppColors.blackTextColor),
                            ),
                          ),
                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   mainAxisAlignment: MainAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       "${AllData.investorData.firstName} ${AllData.investorData.lastName}",
                          //       style: kGoogleStyleTexts.copyWith(
                          //         color: hexToColor(AppColors.blackTextColor)
                          //             .withOpacity(0.87),
                          //         fontSize: 24.0,
                          //       ),
                          //       textAlign: TextAlign.start,
                          //     ),
                          //     Text(
                          //       "(${AllData.investorData.panCard})",
                          //       style: kGoogleStyleTexts.copyWith(
                          //         color: hexToColor(AppColors.blackTextColor)
                          //             .withOpacity(0.87),
                          //         fontSize: 15.0,
                          //       ),
                          //       textAlign: TextAlign.start,
                          //     ),
                          //   ],
                          // ),

                          // Manish jain told Pramod to hide this
                          // Text(
                          //   "Last Fetch Time ${DateFormat('E, d MMM yyyy HH:mm:ss').format(AllData.lastFetchTime)}",
                          //   style: kGoogleStyleTexts.copyWith(
                          //     color: hexToColor(AppColors.blackTextColor)
                          //         .withOpacity(0.87),
                          //     fontSize: 12.0,
                          //   ),
                          //   textAlign: TextAlign.left,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        tileColor: hexToColor(AppColors.appThemeColor),
                        leading: Icon(Icons.person_rounded),
                        title: Text(
                          "Profile",
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.blackTextColor),
                          ),
                        ),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ProfilePage())),
                        // onTap: _logout,
                      ),
                      ListTile(
                        tileColor: hexToColor(AppColors.appThemeColor),
                        leading: const Icon(Icons.auto_graph),
                        title: Text(
                          "Investment Analysis",
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            // fontFamily: 'gilroy',
                            fontSize: 20,
                            color: hexToColor(AppColors.blackTextColor),
                          ),
                        ),
                        onTap: () => {
                          // Navigator.of(context).pop(),
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const GraphAnalysisScreen()))
                        },
                        // onTap: _logout,
                      ),
                      // ListTile(
                      //   tileColor: hexToColor(AppColors.appThemeColor),
                      //   leading: const Icon(Icons.auto_graph),
                      //   title: Text(
                      //     "Portfolio Analysis",
                      //     style: kGoogleStyleTexts.copyWith(
                      //       fontWeight: FontWeight.w700,
                      //       // fontFamily: 'gilroy',
                      //       fontSize: 20,
                      //       color: hexToColor(AppColors.blackTextColor),
                      //     ),
                      //   ),
                      //   // onTap: () => Navigator.of(context).push(
                      //   //     MaterialPageRoute(
                      //   //         builder: (context) => GraphAnalysisScreen())),
                      //   // onTap: _logout,
                      // ),
                      //  Hide settings for now
                      // ListTile(
                      //   tileColor: hexToColor(AppColors.appThemeColor),
                      //   leading: Icon(Icons.settings_outlined),
                      //   title: Text(
                      //     AppStrings.settings,
                      //     style: kGoogleStyleTexts.copyWith(
                      //       fontWeight: FontWeight.w700,
                      //       fontSize: 20,
                      //       color: hexToColor(AppColors.blackTextColor),
                      //     ),
                      //   ),
                      //   onTap: () => Navigator.of(context).push(
                      //       MaterialPageRoute(
                      //           builder: (context) => SettingsPage())),
                      // ),
                      ListTile(
                        tileColor: hexToColor(AppColors.appThemeColor),
                        leading: Icon(Icons.logout_outlined),
                        title: Text(
                          AppStrings.logoutButtonText,
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.blackTextColor),
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
            backgroundColor: hexToColor(AppColors.appThemeColor),
            body: AllData.investedData.current != 0
                ? buildMainDataScreen(context)
                : buildFalseScreen(context),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildMainDataScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: kGoogleStyleTexts.copyWith(
                        color: hexToColor(AppColors.blackTextColor),
                        fontSize: 15.0,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${AllData.investorData.firstName?.trim()} ${AllData.investorData.lastName?.trim()}",
                          style: kGoogleStyleTexts.copyWith(
                            color: hexToColor(AppColors.blackTextColor)
                                .withOpacity(0.87),
                            fontSize: 24.0,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ],
                    ),
                    // Text(
                    //   " (${AllData.investorData.panCard})",
                    //   style: kGoogleStyleTexts.copyWith(
                    //     color: hexToColor(AppColors.blackTextColor)
                    //         .withOpacity(0.87),
                    //     fontSize: 15.0,
                    //   ),
                    //   textAlign: TextAlign.start,
                    // ),
                  ],
                ),

                // Manish Jain told Pramod to hide this
                // Text(
                //   "Last Fetch Time ${DateFormat('E, d MMM yyyy HH:mm:ss').format(AllData.lastFetchTime)}",
                //   style: kGoogleStyleTexts.copyWith(
                //     color:
                //         hexToColor(AppColors.blackTextColor).withOpacity(0.87),
                //     fontSize: 12.0,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Image.asset(
                //     AppImages.logo,
                //     width: MediaQuery.of(context).size.width * 0.7,
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 7, bottom: 10),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          AppStrings.investments,
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.blackTextColor),
                              fontSize: 15.0),
                        ),
                        Text(
                          " (${AllData.investedData.fundData.length})",
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.loginBtnColor),
                              fontSize: 13.0,
                              fontWeight: FontWeight.w100),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      // color: hexToColor(AppColors.whiteTextColor),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Card(
                    elevation: 0,
                    surfaceTintColor: hexToColor(AppColors.whiteTextColor),
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        side: BorderSide(
                          width: 0.6,
                          color: Color(0x42000000), //Colors.white30,
                        )),
                    borderOnForeground: true,
                    color: hexToColor(AppColors.whiteTextColor),
                    //Colors.black.withOpacity(0.25),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Portfolio Summary",
                                  style: kGoogleStyleTexts.copyWith(
                                      color:
                                          hexToColor(AppColors.blackTextColor)
                                              .withOpacity(0.87),
                                      fontSize: 16.50),
                                ),
                                const Divider(
                                  color: Color(0x42000000), //Colors.white30,
                                  thickness: 1,
                                ),
                                // SizedBox(
                                //   height: 2,
                                // ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Icon(
                                    //   Icons.monetization_on_sharp,
                                    //   color:
                                    //   hexToColor(AppColors.loginBtnColor),
                                    // ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const CurrentValueDot(),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          AppStrings.current,
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                      AppColors.blackTextColor)
                                                  .withOpacity(0.85),
                                              fontSize: 13.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "\u{20B9} ",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: AllData.investedData
                                                          .current >
                                                      AllData
                                                          .investedData.invested
                                                  ? hexToColor(
                                                          AppColors.greenAccent)
                                                      .withOpacity(0.85)
                                                  : hexToColor(
                                                          AppColors.redAccent)
                                                      .withOpacity(0.65),
                                              fontWeight: FontWeight.w400,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 22.0),
                                        ),
                                        Text(
                                          "${oCcy.format(AllData.investedData.current)}",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: AllData.investedData
                                                          .current >
                                                      AllData
                                                          .investedData.invested
                                                  ? hexToColor(
                                                          AppColors.greenAccent)
                                                      .withOpacity(0.75)
                                                  : hexToColor(
                                                          AppColors.redAccent)
                                                      .withOpacity(0.70),
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis,
                                              height: 1,
                                              fontSize: 22.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // Icon(
                                              //   Icons.account_balance_wallet_rounded,
                                              //   color: hexToColor(
                                              //       AppColors.loginBtnColor),
                                              // ),
                                              Text(
                                                AppStrings.invested,
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(AppColors
                                                            .blackTextColor)
                                                        .withOpacity(0.68),
                                                    fontSize: 12.0),
                                              ),
                                              Text(
                                                "Rs. ${oCcy.format(AllData.investedData.invested).contains('.00') ? oCcy.format(AllData.investedData.invested).replaceAll('.00', '') : oCcy.format(AllData.investedData.invested)}",
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(AppColors
                                                            .blackTextColor)
                                                        .withOpacity(0.85),
                                                    fontSize: 15.0),
                                              ),
                                            ],
                                          ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Row(
                                          //       children: [
                                          //         // const CurrentValueDot(),
                                          //         Text(
                                          //           "Total Returns ",
                                          //           style: kGoogleStyleTexts.copyWith(
                                          //               color: hexToColor(AppColors
                                          //                       .blackTextColor)
                                          //                   .withOpacity(0.68),
                                          //               fontSize: 12.0),
                                          //         ),
                                          //         const CurrentValueDot(),
                                          //       ],
                                          //     ),
                                          //     Text(
                                          //       "Rs.${oCcy.format(AllData.investedData.totalReturns)}",
                                          //
                                          //       // "${AllData.investedData.totalReturns > 0.0 ? "+" : "-"} Rs.${oCcy.format(AllData.investedData.totalReturns)}",
                                          //       style: kGoogleStyleTexts.copyWith(
                                          //           color: AllData.investedData
                                          //                       .totalReturns >
                                          //                   0.0
                                          //               ? hexToColor(
                                          //                   AppColors.greenAccent)
                                          //               : hexToColor(AppColors
                                          //                       .blackTextColor)
                                          //                   .withOpacity(0.85),
                                          //           fontSize: 14.0),
                                          //       softWrap: true,
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text(
                                          //       AppStrings.current,
                                          //       style: kGoogleStyleTexts.copyWith(
                                          //           color: hexToColor(
                                          //                   AppColors.blackTextColor)
                                          //               .withOpacity(0.68),
                                          //           fontSize: 12.0),
                                          //     ),
                                          //     Text(
                                          //       "Rs. ${oCcy.format(AllData.investedData.current)}",
                                          //       style: kGoogleStyleTexts.copyWith(
                                          //           color: hexToColor(
                                          //                   AppColors.blackTextColor)
                                          //               .withOpacity(0.85),
                                          //           fontSize: 14.0),
                                          //     ),
                                          //   ],
                                          // ),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          // Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text(
                                          //       "IRR",
                                          //       style: kGoogleStyleTexts.copyWith(
                                          //           color: hexToColor(
                                          //                   AppColors.blackTextColor)
                                          //               .withOpacity(0.68),
                                          //           fontSize: 12.0),
                                          //     ),
                                          //     Text(
                                          //       '${AllData.investedData.irr}%',
                                          //       style: kGoogleStyleTexts.copyWith(
                                          //           color: hexToColor(AllData
                                          //                           .investedData
                                          //                           .irr >
                                          //                       0.0
                                          //                   ? AppColors.greenAccent
                                          //                   : AppColors.redAccent)
                                          //               .withOpacity(0.85),
                                          //           fontSize: 14.0),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Column(
                                        //   crossAxisAlignment: CrossAxisAlignment.end,
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         const CurrentValueDot(),
                                        //         Text(
                                        //           " % Returns",
                                        //           style: kGoogleStyleTexts.copyWith(
                                        //               color: hexToColor(AppColors
                                        //                       .blackTextColor)
                                        //                   .withOpacity(0.68),
                                        //               fontSize: 12.0),
                                        //         ),
                                        //         // const CurrentValueDot(),
                                        //       ],
                                        //     ),
                                        //     Text(
                                        //       "${AllData.investedData.absReturns.toStringAsFixed(8).toString().substring(0, AllData.investedData.absReturns.toStringAsFixed(8).toString().length - 6)}%",
                                        //       style: kGoogleStyleTexts.copyWith(
                                        //           color: AllData.investedData
                                        //                       .totalReturns >
                                        //                   0.0
                                        //               ? hexToColor(
                                        //                   AppColors.greenAccent)
                                        //               : hexToColor(AppColors
                                        //                       .blackTextColor)
                                        //                   .withOpacity(0.85),
                                        //           fontSize: 14.0),
                                        //       softWrap: true,
                                        //     ),
                                        //   ],
                                        // ),
                                        // Column(
                                        //   crossAxisAlignment: CrossAxisAlignment.end,
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         const CurrentValueDot(),
                                        //         Text(
                                        //           " Total Returns",
                                        //           style: kGoogleStyleTexts.copyWith(
                                        //               color: hexToColor(AppColors
                                        //                       .blackTextColor)
                                        //                   .withOpacity(0.68),
                                        //               fontSize: 12.0),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     Text(
                                        //       "${AllData.investedData.totalReturns > 0.0 ? "+" : "-"} Rs.${oCcy.format(AllData.investedData.totalReturns)}",
                                        //       style: kGoogleStyleTexts.copyWith(
                                        //           color: AllData.investedData
                                        //                       .totalReturns >
                                        //                   0.0
                                        //               ? hexToColor(
                                        //                   AppColors.greenAccent)
                                        //               : hexToColor(AppColors
                                        //                       .blackTextColor)
                                        //                   .withOpacity(0.85),
                                        //           fontSize: 14.0),
                                        //       softWrap: true,
                                        //     ),
                                        //   ],
                                        // ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        // Column(
                                        //   crossAxisAlignment: CrossAxisAlignment.end,
                                        //   children: [
                                        //     Row(
                                        //       children: [
                                        //         const CurrentValueDot(),
                                        //         Text(
                                        //           " % Returns",
                                        //           style: kGoogleStyleTexts.copyWith(
                                        //               color: hexToColor(AppColors
                                        //                       .blackTextColor)
                                        //                   .withOpacity(0.68),
                                        //               fontSize: 12.0),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     Text(
                                        //       "${AllData.investedData.absReturns.toStringAsFixed(8).toString().substring(0, AllData.investedData.absReturns.toStringAsFixed(8).toString().length - 6)}%",
                                        //       style: kGoogleStyleTexts.copyWith(
                                        //           color: hexToColor(AllData
                                        //                           .investedData
                                        //                           .totalReturns >
                                        //                       0.0
                                        //                   ? AppColors.greenAccent
                                        //                   : AppColors.blackTextColor)
                                        //               .withOpacity(0.85),
                                        //           fontSize: 14.0),
                                        //       softWrap: true,
                                        //     ),
                                        //   ],
                                        // ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            // Icon(
                                            //   Icons.show_chart_rounded,
                                            //   color:
                                            //       hexToColor(AppColors.loginBtnColor),
                                            // ),
                                            Row(
                                              children: [
                                                const CurrentValueDot(),
                                                Text(
                                                  " XIRR",
                                                  style: kGoogleStyleTexts.copyWith(
                                                      color: hexToColor(AppColors
                                                              .blackTextColor)
                                                          .withOpacity(0.68),
                                                      fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "${AllData.investedData.xirr.toStringAsFixed(2)}%"
                                                  .toString(),
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: hexToColor(AllData
                                                              .investedData
                                                              .xirr >
                                                          0.0
                                                      ? AppColors.greenAccent
                                                      : AppColors.redAccent),
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Expanded(
                          //         child: Container(
                          //           padding: const EdgeInsets.symmetric(vertical: 5),
                          //           color: Colors.lightBlueAccent.shade100
                          //               .withOpacity(0.3),
                          //           alignment: Alignment.center,
                          //           width:
                          //               MediaQuery.of(context).size.width * 0.5,
                          //           child: Text("Analyse Investments"),
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: Container(
                          //           padding: EdgeInsets.symmetric(vertical: 5),
                          //           color:
                          //               Colors.amber.shade400.withOpacity(0.6),
                          //           alignment: Alignment.center,
                          //           width:
                          //               MediaQuery.of(context).size.width * 0.5,
                          //           child: Text("Analyse PortFolio"),
                          //         ),
                          //       )
                          //     ])
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                // color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Sort",
                      style: kGoogleStyleTexts.copyWith(
                          color: hexToColor(AppColors.blackTextColor),
                          fontSize: 14.0),
                    ),
                    IconButton(
                      // icon: AnimatedContainer(
                      //   duration: const Duration(seconds: 3),
                      //   child: Transform.rotate(
                      //     angle: srt == '0' ? 0 : 180 * 3.14 / 180,
                      //     child: Icon(
                      //       Icons.sort,
                      //       color: hexToColor(AppColors.loginBtnColor)
                      //           .withOpacity(0.6),
                      //     ),
                      //   ),
                      // ),
                      icon: Icon(
                        srt != '0'
                            ? Icons.arrow_downward_outlined
                            : Icons.arrow_upward_outlined,
                        color: hexToColor(AppColors.loginBtnColor)
                            .withOpacity(0.6),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return buildBottomSheetContainerForSorting(context);
                          },
                        );
                        //builderList
                      },
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return buildBottomSheetContainerForFilters(context);
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: ,
                    children: [
                      Text(
                        "<> ",
                        style: kGoogleStyleTexts.copyWith(
                            color: hexToColor(AppColors.loginBtnColor)
                                .withOpacity(0.7),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Current ($sortFeature)",
                        style: kGoogleStyleTexts.copyWith(
                            color: hexToColor(AppColors.blackTextColor),
                            fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            // padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.vertical,
            itemCount: AllData.investedData.fundData.length,
            itemBuilder: (context, i) {
              final data = AllData.investedData.fundData.toList();
              if (sortFeature == "Current") {
                data.sort((a, b) => (int.parse(srt) == 1
                    ? a.currentValue.compareTo(b.currentValue)
                    : b.currentValue.compareTo(a.currentValue)));
              } else if (sortFeature == "%Returns") {
                data.sort((a, b) => (int.parse(srt) == 1
                    ? a.absReturns.compareTo(b.absReturns)
                    : b.absReturns.compareTo(a.absReturns)));
              } else if (sortFeature == "%XIRR") {
                data.sort((a, b) => (int.parse(srt) == 1
                    ? a.xirr.compareTo(b.xirr)
                    : b.xirr.compareTo(a.xirr)));
              } else if (sortFeature == "Invested") {
                data.sort((a, b) => (int.parse(srt) == 1
                    ? a.invested.compareTo(b.invested)
                    : b.invested.compareTo(a.invested)));
              } else {
                data.sort((a, b) => (int.parse(srt) == 1
                    ? a.schemeName
                        .toLowerCase()
                        .compareTo(b.schemeName.toLowerCase())
                    : b.schemeName
                        .toLowerCase()
                        .compareTo(a.schemeName.toLowerCase())));
              }
              final item = data[i];

              return InkWell(
                onTap: () async {
                  var schemeKey = await AllData.getSchemeData(
                      item.fundCode, item.schemeCode);

                  if (schemeKey != "") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => SchemeSummaryScreen(
                              schemeKey: schemeKey, schemeCurrent: item)),
                    );
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 7),
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    // color: Colors.transparent,
                    decoration: BoxDecoration(
                        color: hexToColor(AppColors.whiteTextColor),
                        //Colors.black.withOpacity(0.3),
                        border: Border.all(
                          color: Colors.black26.withOpacity(0.2),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 08, vertical: 07),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Text(item.schemeName,
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor(AppColors.blackTextColor),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500),
                              softWrap: true,
                              textAlign: TextAlign.left),
                        ),
                        const Divider(
                          color: Color(0x42000000), //Colors.white30,
                          thickness: 0.5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SubHeadingText(item: "Invested"),
                                    ValueText(
                                        item:
                                            "Rs. ${oCcy.format(item.invested).contains('.00') ? oCcy.format(item.invested).replaceAll('.00', '') : oCcy.format(item.invested)}",

                                        // "Rs.${oCcy.format(item.invested)}",
                                        color: AppColors.blackTextColor)
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SubHeadingText(item: "Since Date"),
                                    ValueText(
                                        item:
                                            item.sinceDate.replaceAll('-', '/'),
                                        color: AppColors.blackTextColor)
                                  ],
                                ),
                              ],
                            ),
                            // const Divider(
                            //   thickness: 0.5,
                            //   height: ,
                            //   color: Colors.white24,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SubHeadingText(item: "Current"),
                                    ValueText(
                                        item:
                                            "Rs.${oCcy.format(item.currentValue)}",
                                        color: AppColors.blackTextColor)
                                  ],
                                ),
                                // const Divider(
                                //   color: hexToColor(
                                //                  AppColors.blackTextColor),
                                // ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SubHeadingText(item: "% Rtn."),
                                    ValueText(
                                        item: "${item.absReturns}%",
                                        color: item.absReturns > 0.0
                                            ? AppColors.greenAccent
                                            : AppColors.redAccent)
                                  ],
                                ),
                              ],
                            ),
                            // const Divider(
                            //   thickness: 0.5,
                            //   height: ,
                            //   color: Colors.white24,
                            // ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SubHeadingText(item: "Tot. Returns"),
                                    ValueText(
                                        item:
                                            "Rs.${oCcy.format(item.totalReturns)}",
                                        color: item.totalReturns > 0.0
                                            ? AppColors.greenAccent
                                            : AppColors.redAccent)
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SubHeadingText(item: "XIRR"),
                                    ValueText(
                                        item: "${item.xirr}%",
                                        color: item.xirr > 0.0
                                            ? AppColors.greenAccent
                                            : AppColors.redAccent)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Stack buildFalseScreen(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15.0, bottom: 0.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                AppStrings.investments,
                                style: kGoogleStyleTexts.copyWith(
                                    color: hexToColor(AppColors.blackTextColor),
                                    fontSize: 15.0),
                              ),
                              Text(
                                "(-)",
                                style: kGoogleStyleTexts.copyWith(
                                    color: hexToColor(AppColors.blackTextColor),
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w100),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              side: BorderSide(
                                color: Colors.white30,
                              )),
                          borderOnForeground: true,
                          color: hexToColor(AppColors.whiteTextColor),
                          //Colors.transparent, //hexToColor("#1D1D1D"),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.invested,
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 12.0),
                                          ),
                                          Text(
                                            "Rs.----",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 15.0),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppStrings.current,
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 12.0),
                                          ),
                                          Text(
                                            "Rs.----",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: hexToColor(
                                                      AppColors.currentValue),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                " Total Returns",
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                        color: hexToColor(
                                                            AppColors
                                                                .blackTextColor),
                                                        fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "+ Rs.---- ",
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                        color: hexToColor(
                                                            AppColors
                                                                .blackTextColor),
                                                        fontSize: 15.0),
                                                softWrap: true,
                                              ),
                                              Text(
                                                "(--.--%)",
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                        color: hexToColor(
                                                            AppColors
                                                                .blackTextColor),
                                                        fontSize: 15.0),
                                                softWrap: true,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "XIRR",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 12.0),
                                          ),
                                          Text(
                                            "--.--%".toString(),
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  // color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Sort",
                        style: kGoogleStyleTexts.copyWith(
                            color: hexToColor(AppColors.blackTextColor),
                            fontSize: 14.0),
                      ),
                      IconButton(
                        icon: AnimatedContainer(
                          duration: const Duration(seconds: 3),
                          child: Transform.rotate(
                            angle: srt == '0' ? 0 : 180 * 3.14 / 180,
                            child: Icon(
                              Icons.sort,
                              color: hexToColor(AppColors.currentStatus)
                                  .withOpacity(0.6),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return buildBottomSheetContainerForSorting(
                                  context);
                            },
                          );
                          //builderList
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return buildBottomSheetContainerForFilters(context);
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // crossAxisAlignment: ,
                      children: [
                        Text(
                          "<> ",
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.currentValue)
                                  .withOpacity(0.7),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Current ($sortFeature)",
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.blackTextColor),
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container buildBottomSheetContainerForSorting(BuildContext context) {
    return Container(
      color: hexToColor(AppColors.appThemeColor), //hexToColor("#080808"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Order of sorting',
                style: kGoogleStyleTexts.copyWith(
                    color: hexToColor(AppColors.blackTextColor),
                    fontSize: 14.0),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              RadioListTile(
                tileColor: hexToColor(AppColors.blackTextColor),
                title: Text(
                  'Ascending',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 14.0),
                ),
                value: "1",
                groupValue: srt,
                activeColor: hexToColor(AppColors.loginBtnColor),
                onChanged: (value) {
                  // setState(() {
                  //
                  // });
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => setState(() {
                            srt = value.toString();
                            Navigator.of(context).pop();
                          }));
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                tileColor: hexToColor(AppColors.blackTextColor),
                title: Text(
                  'Descending',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 14.0),
                ),
                value: "0",
                activeColor: hexToColor(AppColors.loginBtnColor),
                groupValue: srt,
                onChanged: (value) {
                  // setState(() {
                  //   srt = value.toString();
                  //   Navigator.of(context).pop();
                  // });
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => setState(() {
                            srt = value.toString();
                            Navigator.of(context).pop();
                          }));
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container buildBottomSheetContainerForFilters(BuildContext context) {
    return Container(
      color: hexToColor(AppColors.appThemeColor), //hexToColor("#121212"),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Sort Investments By',
                style: kGoogleStyleTexts.copyWith(
                    color: hexToColor(AppColors.blackTextColor),
                    fontSize: 14.0),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              RadioListTile(
                title: Text(
                  'Current',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 14.0),
                ),
                selected: true,
                activeColor: hexToColor(AppColors.loginBtnColor),
                value: "Current",
                groupValue: sortFeature,
                onChanged: (value) {
                  setState(() {
                    sortFeature = value.toString();
                    srt = "0";
                    Navigator.of(context).pop();
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                title: Text(
                  'Invested',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 14.0),
                ),
                selected: true,
                activeColor: hexToColor(AppColors.loginBtnColor),
                value: "Invested",
                groupValue: sortFeature,
                onChanged: (value) {
                  setState(() {
                    sortFeature = value.toString();
                    srt = "0";
                    Navigator.of(context).pop();
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                title: Text(
                  '%XIRR',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 14.0),
                ),
                value: "%XIRR",
                groupValue: sortFeature,
                activeColor: hexToColor(AppColors.loginBtnColor),
                onChanged: (value) {
                  setState(() {
                    sortFeature = value.toString();
                    srt = "0";
                    Navigator.of(context).pop();
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                title: Text(
                  '%Returns',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 14.0),
                ),
                value: "%Returns",
                groupValue: sortFeature,
                activeColor: hexToColor(AppColors.loginBtnColor),
                onChanged: (value) {
                  setState(() {
                    sortFeature = value.toString();
                    srt = "0";
                    Navigator.of(context).pop();
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                title: Text(
                  'Alphabetical',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 14.0),
                ),
                value: "Alphabetical",
                groupValue: sortFeature,
                activeColor: hexToColor(AppColors.loginBtnColor),
                onChanged: (value) {
                  setState(() {
                    sortFeature = value.toString();
                    srt = "0";
                    Navigator.of(context).pop();
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class SubHeadingText extends StatelessWidget {
  const SubHeadingText({
    super.key,
    required this.item,
  });

  final item;

  @override
  Widget build(BuildContext context) {
    return Text(
      item,
      style: kGoogleStyleTexts.copyWith(
          color: hexToColor(AppColors.blackTextColor).withOpacity(0.6),
          fontSize: 11.0),
    );
  }
}

class ValueText extends StatelessWidget {
  const ValueText({
    super.key,
    required this.item,
    required this.color,
  });

  final item;
  final color;

  @override
  Widget build(BuildContext context) {
    return Text(
      item.toString(),
      style: kGoogleStyleTexts.copyWith(
          color: hexToColor(color).withOpacity(0.85), fontSize: 13.0),
    );
  }
}

class CurrentValueDot extends StatelessWidget {
  const CurrentValueDot({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        color: hexToColor(AppColors.currentValue),
        shape: BoxShape.circle,
      ),
    );
  }
}

class Modal {
  String name;
  bool isSelected;

  Modal({required this.name, this.isSelected = false});
}
