import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../app_assets_constants/app_strings.dart';
import '../models/investments.dart';
import '../models/investor.dart';
import '../models/token.dart';
import '../utils/AllData.dart';
import '../utils/exit_dialogue.dart';
import '../utils/styleConstants.dart';
import 'dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onBackPressed() async {
    // AllData.investedData = InvestedData(
    //     invested: 0,
    //     current: 0,
    //     totalReturns: 0,
    //     absReturns: 0,
    //     xirr: 0,
    //     //     irr: 0,
    //     sinceDaysCAGR: 0,
    //     fundData: []);
    // AllData.schemeMap = {};
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const ExitDialogue());
    return false;
    // return false;
  }

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
          sinceDaysCAGR: 0,
          fundData: []);
      AllData.schemeMap.clear();
      AllData.investorData = User();
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
  void initState() {
    getData().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) async {
        if (canPop) {
          return;
        }
        await _onBackPressed();
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
            backgroundColor: AppColors.appThemeColor,
            width: MediaQuery.of(context).size.width * 0.75,
            child: ListView(
              // Important: Remove any padding from the ListView.
              // itemExtent: 100,
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColors.currentValue,
                  ),
                  child: Text(
                    "Hii, there...",
                    style: kGoogleStyleTexts.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                ),
                ListTile(
                    tileColor: AppColors.red,
                    title: Text(
                      AppStrings.logout,
                      style: kGoogleStyleTexts.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.whiteTextColor,
                      ),
                    ),
                    onTap: _logout),
              ],
            ),
          ),
          backgroundColor: AppColors.appThemeColor,
          body: SafeArea(
              child: FutureBuilder(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  child: Column(
                    children: [
                      // Container(
                      //   width: MediaQuery.of(context).size.width,
                      //   decoration: const BoxDecoration(
                      //       // color: AppColors.whiteTextColor),
                      //       borderRadius:
                      //           BorderRadius.all(Radius.circular(10))),
                      //   child: Card(
                      //     elevation: 0,
                      //     surfaceTintColor:
                      //         AppColors.whiteTextColor),
                      //     margin: EdgeInsets.zero,
                      //     shape: const RoundedRectangleBorder(
                      //         borderRadius:
                      //             BorderRadius.all(Radius.circular(8)),
                      //         side: BorderSide(
                      //           width: 0.6,
                      //           color: const Color0x42000000), //Colors.white30,
                      //         )),
                      //     borderOnForeground: true,
                      //     color: AppColors
                      //         .whiteTextColor), //Colors.black.withOpacity(0.25),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(
                      //           left: 10, right: 10, bottom: 20, top: 15),
                      //       child: Column(
                      //         // mainAxisAlignment: MainAxisAlignment.start,
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           // Stack(
                      //           //   children: [
                      //           //     // Big Container
                      //           //     Container(
                      //           //       width: 200,
                      //           //       height: 200,
                      //           //       color: Colors.blue,
                      //           //     ),
                      //           //     // Small Container (centered along the top edge and displaced upwards)
                      //           //     Positioned(
                      //           //       top:
                      //           //           -50, // Displace upwards by half of the small container's height
                      //           //       left:
                      //           //           50, // Center the small container horizontally
                      //           //       child: Container(
                      //           //         width: 100,
                      //           //         height: 100,
                      //           //         color: Colors.red,
                      //           //       ),
                      //           //     ),
                      //           //   ],
                      //           // ),
                      //           Text(
                      //             "Hello, Pramod",
                      //             style: kGoogleStyleTexts.copyWith(
                      //               color: AppColors.blackTextColor)
                      //                   .withOpacity(0.87),
                      //               fontSize: 18.0,
                      //             ),
                      //             textAlign: TextAlign.start,
                      //           ),
                      //           const Divider(
                      //             color: const Color0x42000000), //Colors.white30,
                      //             thickness: 1.5,
                      //           ),
                      //           // SizedBox(
                      //           //   height: 5,
                      //           //   child: Container(
                      //           //     width: MediaQuery.sizeOf(context).width,
                      //           //     height: 1,
                      //           //     decoration: BoxDecoration(
                      //           //       color: "#d1d1d1"),
                      //           //       shape: BoxShape.rectangle,
                      //           //     ),
                      //           //   ),
                      //           // ),
                      //           const Column(
                      //             children: [
                      //               Row(
                      //                 mainAxisAlignment:
                      //                     MainAxisAlignment.spaceBetween,
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.start,
                      //                 children: [
                      //                   Text("Pan: "),
                      //                   Text("ALLPD5758D"),
                      //                 ],
                      //               ),
                      //               // Row(
                      //               //   mainAxisAlignment:
                      //               //       MainAxisAlignment.spaceBetween,
                      //               //   crossAxisAlignment:
                      //               //       CrossAxisAlignment.start,
                      //               //   children: [
                      //               //     Text("Pan: "),
                      //               //     Text("ALLPD5758D"),
                      //               //   ],
                      //               // ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 14,
                      ),
                      Card(
                        elevation: 0,
                        surfaceTintColor: AppColors.whiteTextColor,
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            side: BorderSide(
                              width: 0.6,
                              color: const Color(0x42000000), //Colors.white30,
                            )),
                        borderOnForeground: true,
                        // color: AppColors.loginBtnColor)
                        //     .withOpacity(
                        //         0.9), //Colors.black.withOpacity(0.25),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.loginBtnColor,
                                  // AppColors.loginBtnColor),
                                  // AppColors.),
                                  Colors.blueAccent.shade700
                                  // Colors.pinkAccent.shade700
                                ],
                                stops: const [0.25, 1],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                transform: const GradientRotation(0.1),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 20, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   "Portfolio Summary",
                              //   style: kGoogleStyleTexts.copyWith(
                              //       color:
                              //           AppColors.blackTextColor)
                              //               .withOpacity(0.87),
                              //       fontSize: 18.0),
                              // ),

                              Text(
                                "Hello, ${AllData.investorData.firstName} (${AllData.investorData.panCard})",
                                style: kGoogleStyleTexts.copyWith(
                                  color: AppColors.blackTextColor
                                      .withOpacity(0.87),
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const Divider(
                                color:
                                    const Color(0x42000000), //Colors.white30,
                                thickness: 1.5,
                              ),

                              // SizedBox(
                              //   height: 5,
                              //   child: Container(
                              //     width: MediaQuery.sizeOf(context).width,
                              //     height: 1,
                              //     decoration: BoxDecoration(
                              //       color: "#d1d1d1"),
                              //       shape: BoxShape.rectangle,
                              //     ),
                              //   ),
                              // ),
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
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text(
                                        //       AppStrings.current,
                                        //       style: kGoogleStyleTexts.copyWith(
                                        //           color: AppColors
                                        //                   .whiteTextColor)
                                        //               .withOpacity(0.68),
                                        //           fontSize: 14.0),
                                        //     ),
                                        //     Text(
                                        //       "\u{20B9} ${oCcy.format(AllData.investedData.current)}",
                                        //       style: kGoogleStyleTexts.copyWith(
                                        //           color: AppColors
                                        //                   .whiteTextColor)
                                        //               .withOpacity(0.9),
                                        //           fontSize: 24.0),
                                        //     ),
                                        //   ],
                                        // ),
                                        // const SizedBox(
                                        //   height: 10,
                                        // ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.returns,
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: AppColors
                                                      .whiteTextColor
                                                      .withOpacity(0.68),
                                                  fontSize: 12.0),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${AllData.investedData.totalReturns > 0.0 ? "+" : "-"} \u{20B9} ${oCcy.format(AllData.investedData.totalReturns)}",
                                                  style: kGoogleStyleTexts
                                                      .copyWith(
                                                          color: AppColors
                                                              .greenAccent,
                                                          fontSize: 15.0),
                                                ),
                                                Text(
                                                  " (${AllData.investedData.absReturns.toStringAsFixed(8).toString().substring(0, AllData.investedData.absReturns.toStringAsFixed(8).toString().length - 6)}%)",
                                                  style: kGoogleStyleTexts.copyWith(
                                                      color: AllData
                                                                  .investedData
                                                                  .totalReturns >
                                                              0.0
                                                          ? AppColors
                                                              .greenAccent
                                                          : AppColors.redAccent
                                                              .withOpacity(
                                                                  0.75),
                                                      fontSize: 12.0),
                                                  softWrap: true,
                                                ),
                                              ],
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
                                        //     Text(
                                        //       "IRR",
                                        //       style: kGoogleStyleTexts.copyWith(
                                        //           color: AppColors
                                        //                   .blackTextColor)
                                        //               .withOpacity(0.68),
                                        //           fontSize: 14.0),
                                        //     ),
                                        //     Text(
                                        //       '${AllData.investedData.irr}%',
                                        //       style: kGoogleStyleTexts.copyWith(
                                        //           color:
                                        //                   AllData.investedData
                                        //                               .irr >
                                        //                           0.0
                                        //                       ? AppColors
                                        //                           .greenAccent
                                        //                       : AppColors
                                        //                           .redAccent)
                                        //               .withOpacity(0.85),
                                        //           fontSize: 17.0),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.end,
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.end,
                                  //       children: [
                                  //         Row(
                                  //           children: [
                                  //             Container(
                                  //               width: 4,
                                  //               height: 4,
                                  //               decoration: BoxDecoration(
                                  //                 color:
                                  //                     AppColors.currentValue),
                                  //                 shape: BoxShape.circle,
                                  //               ),
                                  //             ),
                                  //             Text(
                                  //               " Total Returns",
                                  //               style: kGoogleStyleTexts.copyWith(
                                  //                   color: AppColors
                                  //                           .blackTextColor)
                                  //                       .withOpacity(0.68),
                                  //                   fontSize: 14.0),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         Text(
                                  //           "${AllData.investedData.totalReturns > 0.0 ? "+" : "-"} \u{20B9}${oCcy.format(AllData.investedData.totalReturns)}",
                                  //           style: kGoogleStyleTexts.copyWith(
                                  //               color: AllData
                                  //                               .investedData
                                  //                               .totalReturns >
                                  //                           0.0
                                  //                       ? AppColors
                                  //                           .greenAccent
                                  //                       : AppColors.redAccent)
                                  //                   .withOpacity(0.85),
                                  //               fontSize: 17.0),
                                  //           softWrap: true,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     const SizedBox(
                                  //       height: 10,
                                  //     ),
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.end,
                                  //       children: [
                                  //         Row(
                                  //           children: [
                                  //             Container(
                                  //               width: 4,
                                  //               height: 4,
                                  //               decoration: BoxDecoration(
                                  //                 color:
                                  //                     AppColors.currentValue),
                                  //                 shape: BoxShape.circle,
                                  //               ),
                                  //             ),
                                  //             Text(
                                  //               " % Returns",
                                  //               style: kGoogleStyleTexts.copyWith(
                                  //                   color: AppColors
                                  //                           .blackTextColor)
                                  //                       .withOpacity(0.68),
                                  //                   fontSize: 14.0),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         Text(
                                  //           "${AllData.investedData.absReturns.toStringAsFixed(8).toString().substring(0, AllData.investedData.absReturns.toStringAsFixed(8).toString().length - 6)}%",
                                  //           style: kGoogleStyleTexts.copyWith(
                                  //               color: AllData
                                  //                               .investedData
                                  //                               .totalReturns >
                                  //                           0.0
                                  //                       ? AppColors
                                  //                           .greenAccent
                                  //                       : AppColors.redAccent)
                                  //                   .withOpacity(0.85),
                                  //               fontSize: 17.0),
                                  //           softWrap: true,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     // const SizedBox(
                                  //     //   height: 10,
                                  //     // ),
                                  //     // Column(
                                  //     //   crossAxisAlignment:
                                  //     //       CrossAxisAlignment.end,
                                  //     //   children: [
                                  //     //     Row(
                                  //     //       children: [
                                  //     //         Container(
                                  //     //           width: 4,
                                  //     //           height: 4,
                                  //     //           decoration: BoxDecoration(
                                  //     //             color:
                                  //     //                 AppColors.currentValue),
                                  //     //             shape: BoxShape.circle,
                                  //     //           ),
                                  //     //         ),
                                  //     //         Text(
                                  //     //           " XIRR",
                                  //     //           style: kGoogleStyleTexts.copyWith(
                                  //     //               color: AppColors
                                  //     //                       .blackTextColor)
                                  //     //                   .withOpacity(0.68),
                                  //     //               fontSize: 14.0),
                                  //     //         ),
                                  //     //       ],
                                  //     //     ),
                                  //     //     Text(
                                  //     //       "${AllData.investedData.xirr.toStringAsFixed(2)}%"
                                  //     //           .toString(),
                                  //     //       style: kGoogleStyleTexts.copyWith(
                                  //     //           color: AllData
                                  //     //                       .investedData
                                  //     //                       .xirr >
                                  //     //                   0.0
                                  //     //               ? AppColors.greenAccent
                                  //     //               : AppColors.redAccent),
                                  //     //           fontSize: 17.0),
                                  //     //     ),
                                  //     //   ],
                                  //     // ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              // color: AppColors.currentValue)
                              //     .withOpacity(0.7),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.loginBtnColor,
                                  // const Color(AppColors.loginBtnColor),
                                  // const Color(AppColors.loginBtnColor),
                                  // const Color(AppColors.),
                                  Colors.blueAccent.shade700
                                  // Colors.pinkAccent.shade700
                                ],
                                stops: const [0.6, 1],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                // transform: const GradientRotation(0),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            AppStrings.reports,
                            style: kGoogleStyleTexts.copyWith(
                                color:
                                    AppColors.whiteTextColor.withOpacity(0.9),
                                fontSize: 20.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasData && snapshot.data == "No Data Error") {
                return const Text("It is okay!!!");
              }
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            },
          ))),
    );
  }

  Future<String> getData() async {
    if (AllData.investedData.sinceDaysCAGR > 0) {
      if (kDebugMode) {
        // print("Api call saved here!!!");
      }
      return Future.value("Data Downloaded Successfully");
    }
    EasyLoading.show(
      status: 'please wait your Data is loading...',
    );

    try {
      var token = Token.instance.token;
      var responseBody =
          jsonDecode(await ApiService().dashboardAPI(token, 10, 0));
      // if (kDebugMode) {
      //   print(responseBody.toString());
      // }
      InvestedData investedData = InvestedData.fromJson(responseBody['data']);
      await EasyLoading.dismiss();
      // if (kDebugMode) {
      //   print("responseBody.toString()");
      // }
      // if (kDebugMode) {
      //   print(investedData.invested);
      // }
      var prefs = SharedPreferences.getInstance();
      prefs.then((pref) =>
          pref.setString('investedData', jsonEncode(responseBody['data'])));

      AllData.setInvestmentData(investedData);
      return Future.value("Data Downloaded Successfully");
    } catch (e) {
      if (kDebugMode) {
        // print(e);
      }
      // var schemes = "No";
      await EasyLoading.dismiss();
      return Future.value("No Data Error");
    }
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
