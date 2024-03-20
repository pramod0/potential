import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';

import '../app_assets_constants/app_strings.dart';
// import 'package:potential/models/token.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// import '../ApiService.dart';
// import '../models/investments.dart';
import '../utils/AllData.dart';
import '../utils/appTools.dart';
import '../utils/styleConstants.dart';

final oCcy = NumberFormat("#,##0.00", "en_US");

// class SchemeSummaryScreen extends StatefulWidget {
//   final widget.schemeKey;
//   final widget.schemeCurrent;
//
//   const SchemeSummaryScreen(
//       {super.key, required this.widget.schemeKey, required this.widget.schemeCurrent});
//
//   @override
//   State<SchemeSummaryScreen> createState() => _SchemeSummaryScreenState();
// }

class SchemeSummaryScreen extends StatefulWidget {
  final schemeKey;
  final schemeCurrent;

  const SchemeSummaryScreen(
      {super.key, required this.schemeKey, required this.schemeCurrent});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SchemeSummaryScreenState();
  }
}

class _SchemeSummaryScreenState extends State<SchemeSummaryScreen>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<SchemeSummaryScreen> {
  String sortFeature = "Current";
  String srt = '0';

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 10),
  //   vsync: this,
  // );

  // late final Animation<double> _animationd = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeOutQuint,
  // );

  // @override
  // void initState() {
  //   super.initState();
  // }

  Future<bool> _onBackPressed(BuildContext context) async {
    Navigator.of(context).pop();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (canPop) async {
        if (canPop) {
          return;
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              hexToColor(AppColors.appThemeColor), //hexToColor("#121212"),
          title: Text(
            "Scheme Analysis",
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
        backgroundColor:
            hexToColor(AppColors.appThemeColor), //hexToColor("#111111"),
        body: SafeArea(child: buildMainDataScreen(context)),
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
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 0.0, bottom: 0.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.schemeCurrent.schemeName,
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.blackTextColor)
                                  .withOpacity(0.8),
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '( ${widget.schemeCurrent.fundName} )',
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.blackTextColor)
                                  .withOpacity(0.8),
                              fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          // color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            side: BorderSide(
                              width: 0.6,
                              color: Colors.black26, //Colors.white30,
                            )),
                        borderOnForeground: true,
                        elevation: 0,
                        color: hexToColor(AppColors.whiteTextColor),
                        surfaceTintColor: hexToColor(AppColors.whiteTextColor),
                        //Colors.transparent, //hexToColor("#1D1D1D"),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                              Text(
                                "Scheme Summary",
                                style: kGoogleStyleTexts.copyWith(
                                    color: hexToColor(AppColors.blackTextColor)
                                        .withOpacity(0.87),
                                    fontSize: 15),
                              ),
                              const Divider(
                                color: Color(0x42000000), //Colors.white30,
                                thickness: 1,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.invested,
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(AppColors
                                                        .blackTextColor)
                                                    .withOpacity(0.65),
                                                fontSize: 11.0),
                                          ),
                                          Text(
                                            "\u{20B9}${oCcy.format(widget.schemeCurrent.invested).replaceFirst('.00', '')}",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 14.0),
                                          ),
                                        ],
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
                                                  color: hexToColor(
                                                      AppColors.currentValue),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                " Total Returns",
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(AppColors
                                                            .blackTextColor)
                                                        .withOpacity(0.65),
                                                    fontSize: 11.0),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${widget.schemeCurrent.totalReturns > 0.0 ? "+" : "-"} \u{20B9}${oCcy.format(widget.schemeCurrent.totalReturns)}",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(widget
                                                                .schemeCurrent
                                                                .totalReturns >
                                                            0.0
                                                        ? AppColors.greenAccent
                                                        : AppColors.redAccent)
                                                    .withOpacity(0.85),
                                                fontSize: 14.0),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppStrings.current,
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(AppColors
                                                        .blackTextColor)
                                                    .withOpacity(0.65),
                                                fontSize: 11.0),
                                          ),
                                          Text(
                                            "\u{20B9}${oCcy.format(widget.schemeCurrent.currentValue)}",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // // ),
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
                                                  color: hexToColor(
                                                      AppColors.currentValue),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                " % Returns",
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(AppColors
                                                            .blackTextColor)
                                                        .withOpacity(0.65),
                                                    fontSize: 11.0),
                                                softWrap: true,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${widget.schemeCurrent.absReturns.toStringAsFixed(8).toString().substring(0, widget.schemeCurrent.absReturns.toStringAsFixed(8).toString().length - 6)}%",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(widget
                                                            .schemeCurrent
                                                            .totalReturns >
                                                        0.0
                                                    ? AppColors.greenAccent
                                                    : AppColors.redAccent),
                                                fontSize: 14.0),
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Container(
                                              //   width: 4,
                                              //   height: 4,
                                              //   decoration: BoxDecoration(
                                              //     color: hexToColor(AppColors.currentValue),
                                              //     shape: BoxShape.circle,
                                              //   ),
                                              // ),
                                              Text(
                                                "Total Units",
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(AppColors
                                                            .blackTextColor)
                                                        .withOpacity(0.65),
                                                    fontSize: 11.0),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${widget.schemeCurrent.unitHolding}",
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 14.0),
                                            softWrap: true,
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // // ),
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
                                                  color: hexToColor(
                                                      AppColors.currentValue),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                " Current NAV",
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(AppColors
                                                            .blackTextColor)
                                                        .withOpacity(0.65),
                                                    fontSize: 11.0),
                                                softWrap: true,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            widget.schemeCurrent.currentNAV
                                                .toString(),
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    AppColors.blackTextColor),
                                                fontSize: 14.0),
                                            softWrap: true,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Container(
                                              //   width: 4,
                                              //   height: 4,
                                              //   decoration: BoxDecoration(
                                              //     color: hexToColor(AppColors.currentValue),
                                              //     shape: BoxShape.circle,
                                              //   ),
                                              // ),
                                              Text(
                                                "CAGR (since)",
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(AppColors
                                                            .blackTextColor)
                                                        .withOpacity(0.65),
                                                    fontSize: 11.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${widget.schemeCurrent.sinceDaysCAGR}%",
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(widget
                                                                .schemeCurrent
                                                                .sinceDaysCAGR >
                                                            0.0
                                                        ? AppColors.greenAccent
                                                        : AppColors.redAccent),
                                                    fontSize: 14.0),
                                                softWrap: true,
                                              ),
                                              Text(
                                                " (${widget.schemeCurrent.sinceDays} days)",
                                                style:
                                                    kGoogleStyleTexts.copyWith(
                                                        color: hexToColor(
                                                            AppColors
                                                                .blackTextColor),
                                                        fontSize: 14.0),
                                                softWrap: true,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // // ),
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
                                                  color: hexToColor(
                                                      AppColors.currentValue),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Text(
                                                " XIRR",
                                                style: kGoogleStyleTexts.copyWith(
                                                    color: hexToColor(AppColors
                                                            .blackTextColor)
                                                        .withOpacity(0.65),
                                                    fontSize: 11.0),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${widget.schemeCurrent.xirr}%"
                                                .toString(),
                                            style: kGoogleStyleTexts.copyWith(
                                                color: hexToColor(
                                                    widget.schemeCurrent.xirr >
                                                            0.0
                                                        ? AppColors.greenAccent
                                                        : AppColors.redAccent),
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(
                                  //   height: 7,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         Row(
                                  //           children: [
                                  //             // Container(
                                  //             //   width: 4,
                                  //             //   height: 4,
                                  //             //   decoration: BoxDecoration(
                                  //             //     color: hexToColor(AppColors.currentValue),
                                  //             //     shape: BoxShape.circle,
                                  //             //   ),
                                  //             // ),
                                  //             Text(
                                  //               "CAGR",
                                  //               style: kGoogleStyleTexts.copyWith(
                                  //                   color: hexToColor(AppColors
                                  //                           .blackTextColor)
                                  //                       .withOpacity(0.65),
                                  //                   fontSize: 11.0),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         Text(
                                  //           "${widget.schemeCurrent.sinceDaysCAGR}%",
                                  //           style: kGoogleStyleTexts.copyWith(
                                  //               color: hexToColor(widget
                                  //                           .schemeCurrent
                                  //                           .sinceDaysCAGR >
                                  //                       0.0
                                  //                   ? AppColors.greenAccent
                                  //                   : AppColors.redAccent),
                                  //               fontSize: 14.0),
                                  //           softWrap: true,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //     // const SizedBox(
                                  //     //   height: 10,
                                  //     // // ),
                                  //     Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.end,
                                  //       children: [
                                  //         Text(
                                  //           "Since",
                                  //           style: kGoogleStyleTexts.copyWith(
                                  //               color: hexToColor(AppColors
                                  //                       .blackTextColor)
                                  //                   .withOpacity(0.65),
                                  //               fontSize: 11.0),
                                  //           softWrap: true,
                                  //         ),
                                  //         Text(
                                  //           "${widget.schemeCurrent.sinceDays} days",
                                  //           style: kGoogleStyleTexts.copyWith(
                                  //               color: hexToColor(
                                  //                   AppColors.blackTextColor),
                                  //               fontSize: 14.0),
                                  //           softWrap: true,
                                  //         ),
                                  //       ],
                                  //     )
                                  //   ],
                                  // ),
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Transactions",
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 15.0),
                ),
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
                              "(${AllData.schemeMap[widget.schemeKey]?.data.length})",
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor(AppColors.blackTextColor),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          children: [
                            Text(
                              "Sort",
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor(AppColors.blackTextColor),
                                  fontSize: 15.0),
                            ),
                            IconButton(
                              icon: AnimatedContainer(
                                duration: const Duration(seconds: 3),
                                child: Transform.rotate(
                                  angle: srt == '0' ? 0 : 180 * 3.14 / 180,
                                  child: Icon(
                                    Icons.sort,
                                    color: hexToColor(AppColors
                                        .loginBtnColor), //Colors.blueAccent,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: AllData.schemeMap[widget.schemeKey]!.length,
            itemBuilder: (context, i) {
              final data = AllData.schemeMap[widget.schemeKey]?.data.toList();
              data?.sort((a, b) => (int.parse(srt) == 1
                  ? a.date.toLowerCase().compareTo(b.date.toLowerCase())
                  : b.date.toLowerCase().compareTo(a.date.toLowerCase())));
              final item = data?[i];

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 17),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.transparent,
                  decoration: BoxDecoration(
                      color: hexToColor(
                          AppColors.whiteTextColor), //Colors.black11,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: 08, vertical: 07),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        ),
                        border: Border.all(
                          color: Colors.black26, //Colors.white24,
                        )),
                    padding: const EdgeInsets.all(11),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Folio Number",
                                    style: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.blackTextColor)
                                                .withOpacity(0.65),
                                        fontSize: 11.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                                Text(item!.folioNumber.toString(),
                                    style: kGoogleStyleTexts.copyWith(
                                        color: hexToColor(
                                            AppColors.blackTextColor),
                                        fontSize: 13.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Installment No",
                                    style: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.blackTextColor)
                                                .withOpacity(0.65),
                                        fontSize: 11.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                                Text(item.installmentNumber.toString(),
                                    style: kGoogleStyleTexts.copyWith(
                                        color: hexToColor(
                                            AppColors.blackTextColor),
                                        fontSize: 13.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Transaction Type",
                                    style: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.blackTextColor)
                                                .withOpacity(0.65),
                                        fontSize: 11.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                                Text(item.transType,
                                    style: kGoogleStyleTexts.copyWith(
                                        color: hexToColor(
                                            AppColors.blackTextColor),
                                        fontSize: 13.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Amount",
                                    style: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.blackTextColor)
                                                .withOpacity(0.65),
                                        fontSize: 11.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                                Text(
                                    "\u{20B9}${oCcy.format(item.amount).replaceFirst('.00', '')}",
                                    style: kGoogleStyleTexts.copyWith(
                                        color: hexToColor(
                                            AppColors.blackTextColor),
                                        fontSize: 13.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          color: Colors.black26,
                          //Colors.white70,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date",
                                    style: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.blackTextColor)
                                                .withOpacity(0.65),
                                        fontSize: 11.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                                Text(item.date.replaceAll("-", "/"),
                                    style: kGoogleStyleTexts.copyWith(
                                        color: hexToColor(
                                            AppColors.blackTextColor),
                                        fontSize: 13.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Units",
                                    style: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.blackTextColor)
                                                .withOpacity(0.65),
                                        fontSize: 11.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                                Text(item.units.toString(),
                                    style: kGoogleStyleTexts.copyWith(
                                        color: hexToColor(
                                            AppColors.blackTextColor),
                                        fontSize: 13.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("N.A.V.",
                                    style: kGoogleStyleTexts.copyWith(
                                        color:
                                            hexToColor(AppColors.blackTextColor)
                                                .withOpacity(0.65),
                                        fontSize: 11.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                                Text(item.nav.toString(),
                                    style: kGoogleStyleTexts.copyWith(
                                        color: hexToColor(
                                            AppColors.blackTextColor),
                                        fontSize: 13.0),
                                    softWrap: true,
                                    textAlign: TextAlign.left),
                              ],
                            ),
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

  Container buildBottomSheetContainerForSorting(BuildContext context) {
    return Container(
      color: hexToColor(AppColors.appThemeColor), //hexToColor("#111111"),
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
                    fontSize: 17.0),
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
                      fontSize: 17.0),
                ),
                value: "1",
                activeColor: hexToColor(AppColors.loginBtnColor),
                groupValue: srt,
                onChanged: (value) {
                  setState(() {
                    srt = value.toString();
                    Navigator.of(context).pop();
                  });
                  // srt = value.toString();
                  // Navigator.of(context).pop();
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
              RadioListTile(
                tileColor: hexToColor(AppColors.blackTextColor),
                title: Text(
                  'Descending',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 17.0),
                ),
                value: "0",
                activeColor: hexToColor(AppColors.loginBtnColor),
                groupValue: srt,
                onChanged: (value) {
                  setState(() {
                    srt = value.toString();
                    Navigator.of(context).pop();
                  });
                  // srt = value.toString();
                  // Navigator.of(context).pop();
                },
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

// Container buildBottomSheetContainerForFilters(BuildContext context) {
//   return Container(
//     color: hexToColor("#111111"),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Align(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Sort Investments By',
//               style: kGoogleStyleTexts.copyWith(
//                   color: hexToColor(AppColors.blackTextColor),
//                   fontSize: 17.0),
//             ),
//           ),
//         ),
//         Column(
//           children: <Widget>[
//             RadioListTile(
//               title: Text(
//                 'Current',
//                 style: kGoogleStyleTexts.copyWith(
//                     color: hexToColor(AppColors.blackTextColor),
//                     fontSize: 17.0),
//               ),
//               selected: true,
//               activeColor: hexToColor("#45b6fe"),
//               value: "Current",
//               groupValue: sortFeature,
//               onChanged: (value) {
//                 setState(() {
//                   sortFeature = value.toString();
//                   srt = "0";
//                   Navigator.of(context).pop();
//                 });
//               },
//               controlAffinity: ListTileControlAffinity.trailing,
//             ),
//             RadioListTile(
//               title: Text(
//                 'Current',
//                 style: kGoogleStyleTexts.copyWith(
//                     color: hexToColor(AppColors.blackTextColor),
//                     fontSize: 17.0),
//               ),
//               selected: true,
//               activeColor: hexToColor("#45b6fe"),
//               value: "Invested",
//               groupValue: sortFeature,
//               onChanged: (value) {
//                 setState(() {
//                   sortFeature = value.toString();
//                   srt = "0";
//                   Navigator.of(context).pop();
//                 });
//               },
//               controlAffinity: ListTileControlAffinity.trailing,
//             ),
//             // RadioListTile(
//             //   title: Text(
//             //     '%XIRR',
//             //     style: kGoogleStyleTexts.copyWith(
//             //         color: hexToColor(AppColors.blackTextColor),
//             //         fontSize: 17.0),
//             //   ),
//             //   value: "%XIRR",
//             //   groupValue: sortFeature,
//             //   onChanged: (value) {
//             //     setState(() {
//             //       sortFeature = value.toString();
//             //       srt = "0";
//             //       Navigator.of(context).pop();
//             //     });
//             //   },
//             //   controlAffinity: ListTileControlAffinity.trailing,
//             // ),
//             // RadioListTile(
//             //   title: Text(
//             //     '%Returns',
//             //     style: kGoogleStyleTexts.copyWith(
//             //         color: hexToColor(AppColors.blackTextColor),
//             //         fontSize: 17.0),
//             //   ),
//             //   value: "%Returns",
//             //   groupValue: sortFeature,
//             //   onChanged: (value) {
//             //     setState(() {
//             //       sortFeature = value.toString();
//             //       srt = "0";
//             //       Navigator.of(context).pop();
//             //     });
//             //   },
//             //   controlAffinity: ListTileControlAffinity.trailing,
//             // ),
//             // RadioListTile(
//             //   title: Text(
//             //     'Alphabetical',
//             //     style: kGoogleStyleTexts.copyWith(
//             //         color: hexToColor(AppColors.blackTextColor),
//             //         fontSize: 17.0),
//             //   ),
//             //   value: "Alphabetical",
//             //   groupValue: sortFeature,
//             //   onChanged: (value) {
//             //     setState(() {
//             //       sortFeature = value.toString();
//             //       srt = "0";
//             //       Navigator.of(context).pop();
//             //     });
//             //   },
//             //   controlAffinity: ListTileControlAffinity.trailing,
//             // ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
}

// class Modal {
//   String name;
//   bool isSelected;
//
//   Modal({required this.name, this.isSelected = false});
// }
