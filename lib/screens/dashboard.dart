import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/models/schemes.dart';
import 'package:potential/models/token.dart';
import 'package:potential/screens/schemeSummaryScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../models/investments.dart';
import '../utils/AllData.dart';
import '../utils/appTools.dart';
import '../utils/styleConstants.dart';
import '../app_assets_constants/AppStrings.dart';

import 'package:intl/intl.dart';

final oCcy = NumberFormat("#,##0.00", "en_US");

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Modal> userList = <Modal>[];
  // final prefs = SharedPreferences.getInstance();
  // String? totalRet = "0";
  String sortFeature = "Current";
  String srt = '0';
  // late int totalFunds;

  Future<String> getData() async {
    EasyLoading.show(
      status: 'please wait your Data is loading...',
    );

    var token = Token.instance.token;
    var responseBody =
        jsonDecode(await ApiService().dashboardAPI(token, 10, 0));
    if (kDebugMode) {
      print(responseBody.toString());
    }
    InvestedData investedData = InvestedData.fromJson(responseBody['data']);
    if (kDebugMode) {
      print("responseBody.toString()");
    }
    if (kDebugMode) {
      print(investedData.invested);
    }
    var prefs = SharedPreferences.getInstance();
    prefs.then((pref) =>
        pref.setString('investedData', responseBody['data'].toString()));

    AllData.setInvestmentData(investedData);
    await EasyLoading.dismiss();
    return Future.value("Data Downloaded Successfully");
  }

  Future<String> getSchemeData(String fund, String scheme) async {
    try {
      EasyLoading.show(
        status: 'please wait your Data is loading...',
      );
      if (AllData.schemeMap.containsKey('${fund}_$scheme')) {
        await EasyLoading.dismiss();
        return '${fund}_${scheme.toString()}';
      }
      var token = Token.instance.token;
      if (kDebugMode) {
        print(token);
      }
      var responseBody =
          jsonDecode(await ApiService().schemeSummaryAPI(token, fund, scheme));

      if (kDebugMode) {
        print("summary");
        print(responseBody.toString());
      }
      SchemeData schemeData = SchemeData.fromJson(responseBody['fundData']);

      if (kDebugMode) {
        print("responseBody.toString()");
      }
      if (kDebugMode) {
        print(schemeData.length);
      }

      AllData.setSchemeSummary(schemeData);
      if (kDebugMode) {
        print(schemeData.length);
      }
      var prefs = SharedPreferences.getInstance();
      prefs.then(
          (pref) => pref.setString('allSchemes', AllData.schemeMap.toString()));
      await EasyLoading.dismiss();
      if (kDebugMode) {
        print(schemeData.length);
      }
      return '${fund}_${scheme.toString()}';
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      var schemes = "No";
      await EasyLoading.dismiss();
      return "";
    }
  }

  @override
  void initState() {
    getData().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    AllData.investedData = InvestedData(
        invested: 0,
        current: 0,
        totalReturns: 0,
        absReturns: 0,
        xirr: 0,
        irr: 0,
        sinceDaysCAGR: 0,
        fundData: []);
    Navigator.of(context).pop();
    return false;
  }

  // _iconControl(bool like) {
  //   if (like == false) {
  //     return const Icon(Icons.favorite_border);
  //   } else {
  //     return const Icon(
  //       Icons.favorite,
  //       color: Colors.red,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: hexToColor(AppColors.appThemeColor),
        body: SafeArea(
          child: AllData.investedData.current != 0
              ? buildMainDataScreen(context)
              : buildFalseScreen(context),
        ),
      ),
    );
  }

  Column buildMainDataScreen(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: hexToColor(AppColors.whiteTextColor),
                                fontSize: 15.0),
                          ),
                          Text(
                            " (${AllData.investedData.fundData.length})",
                            style: kGoogleStyleTexts.copyWith(
                                color: hexToColor("#FCAA00").withOpacity(0.8),
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
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          side: BorderSide(
                            color: Colors.white30,
                          )),
                      borderOnForeground: true,
                      color: Colors.black.withOpacity(0.25),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 15),
                        child: Column(
                          children: [
                            Text(
                              "Portfolio Summary",
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor(AppColors.whiteTextColor)
                                      .withOpacity(0.87),
                                  fontSize: 18.0),
                            ),
                            const Divider(
                              color: Colors.white30,
                              thickness: 1.5,
                            ),
                            // SizedBox(
                            //   height: 5,
                            //   child: Container(
                            //     width: MediaQuery.sizeOf(context).width,
                            //     height: 1,
                            //     decoration: BoxDecoration(
                            //       color: hexToColor("#d1d1d1"),
                            //       shape: BoxShape.rectangle,
                            //     ),
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          Text(
                                            AppStrings.invested,
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(AppColors
                                                        .whiteTextColor)
                                                    .withOpacity(0.68),
                                                fontSize: 14.0),
                                          ),
                                          Text(
                                            "\u{20B9} ${oCcy.format(AllData.investedData.invested)}",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(AppColors
                                                        .whiteTextColor)
                                                    .withOpacity(0.85),
                                                fontSize: 17.0),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.current,
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(AppColors
                                                        .whiteTextColor)
                                                    .withOpacity(0.68),
                                                fontSize: 14.0),
                                          ),
                                          Text(
                                            "\u{20B9} ${oCcy.format(AllData.investedData.current)}",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(AppColors
                                                        .whiteTextColor)
                                                    .withOpacity(0.85),
                                                fontSize: 17.0),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "IRR",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(AppColors
                                                        .whiteTextColor)
                                                    .withOpacity(0.68),
                                                fontSize: 14.0),
                                          ),
                                          Text(
                                            '${AllData.investedData.irr} %',
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(AppColors
                                                        .whiteTextColor)
                                                    .withOpacity(0.85),
                                                fontSize: 17.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: hexToColor("#FCAF23"),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text(
                                              " Total Returns",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: hexToColor(AppColors
                                                          .whiteTextColor)
                                                      .withOpacity(0.68),
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "+ \u{20B9}${oCcy.format(AllData.investedData.totalReturns)}",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                      AppColors.whiteTextColor)
                                                  .withOpacity(0.85),
                                              fontSize: 17.0),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 4,
                                              height: 4,
                                              decoration: BoxDecoration(
                                                color: hexToColor("#FCAF23"),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Text(
                                              " % Returns",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: hexToColor(AppColors
                                                          .whiteTextColor)
                                                      .withOpacity(0.68),
                                                  fontSize: 14.0),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${AllData.investedData.absReturns.toStringAsFixed(8).toString().substring(0, AllData.investedData.absReturns.toStringAsFixed(8).toString().length - 6)}%",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                      AppColors.whiteTextColor)
                                                  .withOpacity(0.85),
                                              fontSize: 17.0),
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "XIRR",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                      AppColors.whiteTextColor)
                                                  .withOpacity(0.68),
                                              fontSize: 14.0),
                                        ),
                                        Text(
                                          "${AllData.investedData.xirr.toStringAsFixed(2)}%"
                                              .toString(),
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                      AppColors.whiteTextColor)
                                                  .withOpacity(0.85),
                                              fontSize: 17.0),
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      children: [
                        Text(
                          "Sort",
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.whiteTextColor),
                              fontSize: 17.0),
                        ),
                        IconButton(
                          icon: AnimatedContainer(
                            duration: const Duration(seconds: 3),
                            child: Transform.rotate(
                              angle: srt == '0' ? 0 : 180 * 3.14 / 180,
                              child: Icon(
                                Icons.sort,
                                color: hexToColor("#FCAA00").withOpacity(0.6),
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
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Text(
                          "<> ",
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor("#FCAF23").withOpacity(0.7),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Current ($sortFeature)",
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.whiteTextColor),
                              fontSize: 14.0),
                        ),
                      ],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return buildBottomSheetContainerForFilters(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
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
                  var schemeKey =
                      await getSchemeData(item.fundCode, item.schemeCode);

                  schemeKey != ""
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => SchemeSummaryScreen(
                                  schemeKey: schemeKey, schemeCurrent: item)),
                        )
                      : print("Hello its fine");
                },
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      // color: Colors.transparent,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          border: Border.all(
                            color: Colors.white24,
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
                                    color: hexToColor(AppColors.whiteTextColor)
                                        .withOpacity(0.7),
                                    fontSize: 14.0),
                                softWrap: true,
                                textAlign: TextAlign.left),
                          ),
                          const Divider(
                            color: Colors.white30,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Invested",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: hexToColor(
                                                    AppColors.whiteTextColor)
                                                .withOpacity(0.6),
                                            fontSize: 13.0),
                                      ),
                                      Text(
                                        "\u{20B9}${oCcy.format(int.parse(item.invested.toString()))}",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: Colors.white60,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Since Date",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: hexToColor(
                                                    AppColors.whiteTextColor)
                                                .withOpacity(0.6),
                                            fontSize: 13.0),
                                      ),
                                      Text(
                                        item.sinceDate.replaceAll('-', '/'),
                                        style: kGoogleStyleTexts.copyWith(
                                            color: Colors.white60,
                                            fontSize: 16.0),
                                      )
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Current",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: hexToColor(
                                                    AppColors.whiteTextColor)
                                                .withOpacity(0.6),
                                            fontSize: 13.0),
                                      ),
                                      Text(
                                        "\u{20B9}${oCcy.format(item.currentValue)}",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: Colors.white60,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  // const Divider(
                                  //   color: Colors.white60,
                                  // ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "XIRR",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: hexToColor(
                                                    AppColors.whiteTextColor)
                                                .withOpacity(0.6),
                                            fontSize: 13.0),
                                      ),
                                      Text(
                                        "${item.xirr} %",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: Colors.white60,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Tot. Returns",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: hexToColor(
                                                    AppColors.whiteTextColor)
                                                .withOpacity(0.6),
                                            fontSize: 13.0),
                                      ),
                                      Text(
                                        "\u{20B9}${oCcy.format(item.totalReturns)}",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: Colors.white60,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "% Rtn.",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: hexToColor(
                                                    AppColors.whiteTextColor)
                                                .withOpacity(0.6),
                                            fontSize: 13.0),
                                      ),
                                      Text(
                                        "${item.absReturns}%",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: Colors.white60,
                                            fontSize: 16.0),
                                      ),
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
                ),
              );

              // if (sortFeature == "Current") {
              //   // data?.sort((a, b) =>
              //   //     b.current?.compareTo(a.current as num) as int);
              //   // //final sortedItems=(int.parse(order))==1? investedData?.investmentData?.fundData!.reversed.toList(): investedData?.investmentData?.fundData!;
              //
              //   return ListTile(
              //     title: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
              //       child: Container(
              //         width: MediaQuery.of(context).size.width,
              //         decoration: const BoxDecoration(
              //             color: Colors.transparent,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(10))),
              //         padding: const EdgeInsets.symmetric(horizontal: 05),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Container(
              //               width: 250,
              //               decoration: const BoxDecoration(
              //                   color: Colors.transparent,
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(5))),
              //               child: Text(
              //                 "${item.schemeName}",
              //                 style: kGoogleStyleTexts.copyWith(
              //                     color: hexToColor(AppColors.whiteTextColor), fontSize: 14.0),
              //                 softWrap: true,
              //               ),
              //             ),
              //             // Align(
              //             //   alignment: Alignment.topCenter,
              //             //   child: Row(
              //             //     mainAxisAlignment:
              //             //         MainAxisAlignment.spaceBetween,
              //             //     crossAxisAlignment:
              //             //         CrossAxisAlignment.start,
              //             //     children: [],
              //             //   ),
              //             // ),
              //             Column(
              //               children: [
              //                 Align(
              //                   alignment: Alignment.centerRight,
              //                   child: Text(
              //                     "\u{20B9}${oCcy.format(item.currentValue)}",
              //                     style: kGoogleStyleTexts.copyWith(
              //                         color: Colors.blueAccent[400],
              //                         fontSize: 14.0),
              //                   ),
              //                 ),
              //                 Align(
              //                   alignment: Alignment.centerRight,
              //                   child: Text(
              //                     "(\u{20B9}${oCcy.format(item.invested)})",
              //                     style: kGoogleStyleTexts.copyWith(
              //                         color: hexToColor(AppColors.whiteTextColor),
              //                         fontSize: 12.0),
              //                   ),
              //                 ),
              //               ],
              //             )
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // } else if (sortFeature == "%Returns") {
              //   return ListTile(
              //     title: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
              //       child: Container(
              //         width: MediaQuery.of(context).size.width,
              //         decoration: const BoxDecoration(
              //             color: Colors.transparent,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(10))),
              //         padding: const EdgeInsets.symmetric(horizontal: 05),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Container(
              //               width: 250,
              //               decoration: const BoxDecoration(
              //                   color: Colors.transparent,
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(5))),
              //               child: Text(
              //                 "${item.schemeName}",
              //                 style: kGoogleStyleTexts.copyWith(
              //                     color: hexToColor(AppColors.whiteTextColor), fontSize: 14.0),
              //                 softWrap: true,
              //               ),
              //             ),
              //             // Align(
              //             //   alignment: Alignment.topCenter,
              //             //   child: Row(
              //             //     mainAxisAlignment:
              //             //         MainAxisAlignment.spaceBetween,
              //             //     crossAxisAlignment:
              //             //         CrossAxisAlignment.start,
              //             //     children: [],
              //             //   ),
              //             // ),
              //             Column(
              //               children: [
              //                 Align(
              //                   alignment: Alignment.topCenter,
              //                   child: Text(
              //                     "${item.absReturns.toStringAsFixed(2)}%",
              //                     style: kGoogleStyleTexts.copyWith(
              //                         color: Colors.blueAccent[400],
              //                         fontSize: 14.0),
              //                   ),
              //                 ),
              //                 Align(
              //                   alignment: Alignment.centerRight,
              //                   child: Text(
              //                     "(\u{20B9}${oCcy.format(item.invested)})",
              //                     style: kGoogleStyleTexts.copyWith(
              //                         color: hexToColor(AppColors.whiteTextColor),
              //                         fontSize: 12.0),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // } else if (sortFeature == "%XIRR") {
              //   return ListTile(
              //     title: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
              //       child: Container(
              //         width: MediaQuery.of(context).size.width,
              //         decoration: const BoxDecoration(
              //             color: Colors.transparent,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(10))),
              //         padding: const EdgeInsets.symmetric(horizontal: 05),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Container(
              //               width: 250,
              //               decoration: const BoxDecoration(
              //                   color: Colors.transparent,
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(5))),
              //               child: Text(
              //                 "${item.schemeName}",
              //                 style: kGoogleStyleTexts.copyWith(
              //                     color: hexToColor(AppColors.whiteTextColor), fontSize: 14.0),
              //                 softWrap: true,
              //               ),
              //             ),
              //             // Align(
              //             //   alignment: Alignment.topCenter,
              //             //   child: Row(
              //             //     mainAxisAlignment:
              //             //         MainAxisAlignment.spaceBetween,
              //             //     crossAxisAlignment:
              //             //         CrossAxisAlignment.start,
              //             //     children: [
              //             //
              //             //
              //             //     ],
              //             //   ),
              //             // ),
              //             Column(
              //               children: [
              //                 Align(
              //                   alignment: Alignment.centerRight,
              //                   child: Text(
              //                     "${oCcy.format(item.xirr)}%",
              //                     style: kGoogleStyleTexts.copyWith(
              //                         color: Colors.blueAccent[400],
              //                         fontSize: 14.0),
              //                   ),
              //                 ),
              //                 Align(
              //                   alignment: Alignment.centerRight,
              //                   child: Text(
              //                     "(\u{20B9}${oCcy.format(item.invested)})",
              //                     style: kGoogleStyleTexts.copyWith(
              //                         color: hexToColor(AppColors.whiteTextColor),
              //                         fontSize: 12.0),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // } else {
              //   return ListTile(
              //     title: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 8.0),
              //       child: Container(
              //         width: MediaQuery.of(context).size.width,
              //         decoration: const BoxDecoration(
              //             color: Colors.transparent,
              //             borderRadius:
              //                 BorderRadius.all(Radius.circular(10))),
              //         padding: const EdgeInsets.symmetric(horizontal: 05),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Container(
              //               width: 250,
              //               decoration: const BoxDecoration(
              //                   color: Colors.transparent,
              //                   borderRadius:
              //                       BorderRadius.all(Radius.circular(5))),
              //               child: Text(
              //                 "${item.schemeName}",
              //                 style: kGoogleStyleTexts.copyWith(
              //                     color: hexToColor(AppColors.whiteTextColor), fontSize: 14.0),
              //                 softWrap: true,
              //               ),
              //             ),
              //             // const Align(
              //             //   alignment: Alignment.topCenter,
              //             //   child: Row(
              //             //     mainAxisAlignment:
              //             //         MainAxisAlignment.spaceBetween,
              //             //     crossAxisAlignment:
              //             //         CrossAxisAlignment.start,
              //             //     children: [],
              //             //   ),
              //             // ),
              //             Column(
              //               children: [
              //                 Align(
              //                   alignment: Alignment.centerRight,
              //                   child: Text(
              //                     "\u{20B9}${oCcy.format(item.currentValue)}",
              //                     style: kGoogleStyleTexts.copyWith(
              //                         color: Colors.blueAccent[400],
              //                         fontSize: 14.0),
              //                   ),
              //                 ),
              //                 Align(
              //                   alignment: Alignment.centerRight,
              //                   child: Text(
              //                     "(\u{20B9}${oCcy.format(item.invested)})",
              //                     style: kGoogleStyleTexts.copyWith(
              //                         color: hexToColor(AppColors.whiteTextColor),
              //                         fontSize: 12.0),
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // }
            },
          ),
        ),
      ],
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
                                    color: hexToColor(AppColors.whiteTextColor),
                                    fontSize: 15.0),
                              ),
                              Text(
                                "(-)",
                                style: kGoogleStyleTexts.copyWith(
                                    color: hexToColor(AppColors.whiteTextColor),
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
                            color: Colors.transparent,
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
                          color: Colors.transparent, //hexToColor("#1D1D1D"),
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
                                                    AppColors.whiteTextColor),
                                                fontSize: 12.0),
                                          ),
                                          Text(
                                            "\u{20B9}----",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
                                                fontSize: 15.0),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppStrings.current,
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
                                                fontSize: 12.0),
                                          ),
                                          Text(
                                            "\u{20B9}----",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
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
                                                  color: hexToColor("#FCAF23"),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                " Total Returns",
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                        color: hexToColor(
                                                            AppColors
                                                                .whiteTextColor),
                                                        fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "+ \u{20B9}---- ",
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                        color: hexToColor(
                                                            AppColors
                                                                .whiteTextColor),
                                                        fontSize: 15.0),
                                                softWrap: true,
                                              ),
                                              Text(
                                                "(--.--%)",
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                        color: hexToColor(
                                                            AppColors
                                                                .whiteTextColor),
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
                                                    AppColors.whiteTextColor),
                                                fontSize: 12.0),
                                          ),
                                          Text(
                                            "--.--%".toString(),
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.whiteTextColor),
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
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 100,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: [
                            Text(
                              "Sort",
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor(AppColors.whiteTextColor),
                                  fontSize: 17.0),
                            ),
                            IconButton(
                              icon: AnimatedContainer(
                                duration: const Duration(seconds: 3),
                                child: Transform.rotate(
                                  angle: srt == '0' ? 0 : 180 * 3.14 / 180,
                                  child: const Icon(
                                    Icons.sort,
                                    color: Colors.blueAccent,
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
                      ),
                      TextButton(
                        child: Row(
                          children: [
                            Text(
                              "<> ",
                              style: kGoogleStyleTexts.copyWith(
                                  color: Colors.blueAccent[400],
                                  fontSize: 14.0),
                            ),
                            Text(
                              "Current ($sortFeature)",
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor(AppColors.whiteTextColor),
                                  fontSize: 14.0),
                            ),
                          ],
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return buildBottomSheetContainerForFilters(
                                  context);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Container buildBottomSheetContainerForSorting(BuildContext context) {
    return Container(
      color: hexToColor("#121212"),
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
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 17.0),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              RadioListTile(
                tileColor: hexToColor(AppColors.whiteTextColor),
                title: Text(
                  'Ascending',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 17.0),
                ),
                value: "1",
                groupValue: srt,
                onChanged: (value) {
                  setState(() {
                    srt = value.toString();
                    Navigator.of(context).pop();
                  });
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                tileColor: hexToColor(AppColors.whiteTextColor),
                title: Text(
                  'Descending',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 17.0),
                ),
                value: "0",
                groupValue: srt,
                onChanged: (value) {
                  setState(() {
                    srt = value.toString();
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

  Container buildBottomSheetContainerForFilters(BuildContext context) {
    return Container(
      color: hexToColor("#121212"),
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
                    color: hexToColor(AppColors.whiteTextColor),
                    fontSize: 17.0),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              RadioListTile(
                title: Text(
                  'Current',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 17.0),
                ),
                selected: true,
                activeColor: hexToColor("#45b6fe"),
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
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 17.0),
                ),
                selected: true,
                activeColor: hexToColor("#45b6fe"),
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
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 17.0),
                ),
                value: "%XIRR",
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
                  '%Returns',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 17.0),
                ),
                value: "%Returns",
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
                  'Alphabetical',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 17.0),
                ),
                value: "Alphabetical",
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
            ],
          ),
        ],
      ),
    );
  }
}

class ExitDialogue extends StatelessWidget {
  const ExitDialogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: hexToColor("#101010"),
      title: Text(
        "Exit App",
        style: kGoogleStyleTexts.copyWith(
            color: hexToColor(AppColors.whiteTextColor), fontSize: 18.0),
      ),
      content: Builder(
        builder: (context) {
          return SizedBox(
            height: 100,
            width: 200,
            child: Column(
              children: [
                Text(
                  "Are you sure you want to exit the app?",
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.whiteTextColor),
                      fontSize: 15.0),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15.0, top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 90,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    hexToColor(AppColors.whiteTextColor),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                side: const BorderSide(
                                    width: 0.5, color: Colors.black26)),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(
                              "Cancel",
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black54,
                                fontSize: 15.0,
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 90,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffC93131),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            onPressed: () async {
                              Navigator.pop(context, true);
                            },
                            child: Text(
                              "Exit",
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                color: hexToColor(AppColors.whiteTextColor),
                                fontSize: 15.0,
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Modal {
  String name;
  bool isSelected;

  Modal({required this.name, this.isSelected = false});
}
