import 'dart:math';

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

final oCcy = NumberFormat("#,##,##0.00", "en_US"); //changed from #,##0.00

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
  //
  // Future<bool> _onBackPressed(BuildContext context) async {
  //   Navigator.of(context).pop();
  //   return false;
  // }

  Column buildXIRR(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildMainCardField(context, "XIRR"),
        Text(
          "${AllData.investedData.xirr.toStringAsFixed(2)}%".toString(),
          style: kGoogleStyleTexts.copyWith(
            color: hexToColor(AllData.investedData.xirr > 0.0
                ? AppColors.greenAccent
                : AppColors.redAccent),
            fontWeight: FontWeight.w500,
            fontSize: 14.0 * MediaQuery.of(context).size.width / 360,
          ),
        ),
      ],
    );
  }

  Column buildAbsReturns(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildMainCardField(context, "% Returns"),
        Text(
          "${AllData.investedData.totalReturns > 0.0 ? "+ " : ""}${AllData.investedData.absReturns.toStringAsFixed(8).toString().substring(0, AllData.investedData.absReturns.toStringAsFixed(8).toString().length - 6)}%",
          // "${AllData.investedData.absReturns.toStringAsFixed(8).toString().substring(0, AllData.investedData.absReturns.toStringAsFixed(8).toString().length - 6)}%",
          style: kGoogleStyleTexts.copyWith(
            color: AllData.investedData.totalReturns > 0.0
                ? hexToColor(AppColors.greenAccent)
                : hexToColor(AppColors.redAccent),
            fontWeight: FontWeight.w500,
            fontSize: 14.0 * MediaQuery.of(context).size.width / 360,
          ),
          softWrap: true,
        ),
      ],
    );
  }

  Column buildTotalReturns(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildMainCardField(context, "Total Returns"),
        Text(
          "${AllData.investedData.totalReturns > 0.0 ? "+" : ""} ${AppStrings.rupeeSign} ${oCcy.format(AllData.investedData.totalReturns)}",
          style: kGoogleStyleTexts.copyWith(
            color: AllData.investedData.totalReturns > 0.0
                ? hexToColor(AppColors.greenAccent)
                : hexToColor(AppColors.redAccent),
            fontWeight: FontWeight.w500,
            fontSize: 14.0 * MediaQuery.of(context).size.width / 360,
          ),
          softWrap: true,
        ),
      ],
    );
  }

  Column buildInvested(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildMainCardField(context, AppStrings.invested),
        Text(
          "${AppStrings.rupeeSign} ${oCcy.format(AllData.investedData.invested).contains('.00') ? oCcy.format(AllData.investedData.invested).replaceAll('.00', '') : oCcy.format(AllData.investedData.invested)}",
          style: kGoogleStyleTexts.copyWith(
            color: hexToColor(AppColors.investedValueMain),
            fontSize: 14.0 * MediaQuery.of(context).size.width / 360,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Text buildMainCardField(BuildContext context, text) {
    return Text(
      text,
      style: kGoogleStyleTexts.copyWith(
        color: hexToColor(AppColors.mainCardField),
        fontSize: 12.0 * MediaQuery.of(context).size.width / 360,
      ),
    );
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
              hexToColor(AppColors.homeBG), //hexToColor("#121212"),
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
        backgroundColor: hexToColor(AppColors.homeBG),
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
          Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0,
                    surfaceTintColor: hexToColor(AppColors.whiteTextColor),
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          0 * MediaQuery.of(context).size.width / 360)),
                    ),
                    // borderOnForeground: true,
                    color: hexToColor(AppColors.contrastContainer)
                        .withOpacity(0.6),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          left: 16 * MediaQuery.of(context).size.width / 360,
                          right: 16 * MediaQuery.of(context).size.width / 360,
                          top: 16 * MediaQuery.of(context).size.width / 360,
                          bottom: 10 * MediaQuery.of(context).size.width / 360),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.schemeCurrent.schemeName,
                            style: kGoogleStyleTexts.copyWith(
                                color: hexToColor(AppColors.blackTextColor)
                                    .withOpacity(0.8),
                                fontSize: 16.0 *
                                    MediaQuery.of(context).size.width /
                                    360,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '(${widget.schemeCurrent.fundName})',
                            style: kGoogleStyleTexts.copyWith(
                                color: hexToColor(AppColors.blackTextColor)
                                    .withOpacity(0.8),
                                fontSize: 12.0 *
                                    MediaQuery.of(context).size.width /
                                    360),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      borderOnForeground: true,
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      color: hexToColor(AppColors.whiteTextColor),
                      surfaceTintColor: hexToColor(AppColors.whiteTextColor),
                      //Colors.transparent, //hexToColor("#1D1D1D"),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              left:
                                  16 * MediaQuery.of(context).size.width / 360,
                              right:
                                  16 * MediaQuery.of(context).size.width / 360,
                              top: 10 * MediaQuery.of(context).size.width / 360,
                            ),
                            color: hexToColor(AppColors.whiteTextColor),
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total returns:",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor("#697586")
                                              .withOpacity(0.87),
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      width: 4 *
                                          MediaQuery.of(context).size.width /
                                          360,
                                    ),
                                    Text(
                                      "${widget.schemeCurrent.totalReturns > 0.0 ? "+ " : "- "}\u{20B9} ${oCcy.format(widget.schemeCurrent.totalReturns > 0.0 ? widget.schemeCurrent.totalReturns : widget.schemeCurrent.totalReturns * -1)} ",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(widget.schemeCurrent
                                                      .totalReturns >
                                                  0.0
                                              ? AppColors.greenAccent
                                              : AppColors.redAccent),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0),
                                      softWrap: true,
                                    ),
                                    Text(
                                      "(${widget.schemeCurrent.absReturns.toStringAsFixed(8).toString().substring(0, widget.schemeCurrent.absReturns.toStringAsFixed(8).toString().length - 6)}%)",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(widget.schemeCurrent
                                                      .totalReturns >
                                                  0.0
                                              ? AppColors.greenAccent
                                              : AppColors.redAccent),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.0),
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: hexToColor("#96B0BD")
                                .withOpacity(0.3), //Colors.white30,
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left:
                                  20 * MediaQuery.of(context).size.width / 360,
                              right:
                                  20 * MediaQuery.of(context).size.width / 360,
                              top: 6 * MediaQuery.of(context).size.width / 360,
                              bottom:
                                  6 * MediaQuery.of(context).size.width / 360,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                buildSummaryFieldRow(
                                    "Total Units",
                                    oCcy
                                        .format(
                                            widget.schemeCurrent.unitHolding)
                                        .replaceFirst('.00', ''),
                                    context),
                                buildSummaryFieldRow(
                                    AppStrings.current,
                                    "\u{20B9} ${oCcy.format(widget.schemeCurrent.currentValue).replaceFirst('.00', '')}",
                                    context),
                                buildSummaryFieldRow(
                                    "Latest N.A.V",
                                    oCcy
                                        .format(widget.schemeCurrent.currentNAV)
                                        .replaceFirst('.00', ''),
                                    context),
                                buildSummaryFieldRow(
                                    AppStrings.invested,
                                    "\u{20B9} ${oCcy.format(widget.schemeCurrent.invested).replaceFirst('.00', '')}",
                                    context),
                                buildSummaryFieldRow(
                                    "Since",
                                    formattedDate(
                                        widget.schemeCurrent.sinceDate),
                                    context),
                              ],
                            ),
                          ),
                          Divider(
                            color: hexToColor("#96B0BD")
                                .withOpacity(0.3), //Colors.white30,
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 18.0 *
                                    MediaQuery.of(context).size.width /
                                    360,
                                vertical: 12.0 *
                                    MediaQuery.of(context).size.width /
                                    360),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildSummaryFieldColumnContainer(
                                    "Since Days",
                                    widget.schemeCurrent.sinceDays,
                                    true,
                                    context),
                                buildSummaryFieldColumnContainer(
                                    "CAGR",
                                    widget.schemeCurrent.sinceDaysCAGR,
                                    widget.schemeCurrent.sinceDaysCAGR > 0.0,
                                    context),
                                buildSummaryFieldColumnContainer(
                                    "XIRR",
                                    widget.schemeCurrent.xirr,
                                    widget.schemeCurrent.xirr > 0.0,
                                    context)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            // padding: EdgeInsets.zero,
            padding: EdgeInsets.only(
                top: 8.0 * MediaQuery.of(context).size.width / 360),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Container(
                //   padding: EdgeInsets.symmetric(
                //       horizontal: 26 * MediaQuery.of(context).size.width / 360),
                //   child: Text(
                //     "Transactions",
                //     style: kGoogleStyleTexts.copyWith(
                //         color: hexToColor(AppColors.blackTextColor),
                //         fontSize:
                //             16.0 * MediaQuery.of(context).size.width / 360),
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(
                          10 * MediaQuery.of(context).size.width / 360))),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20 * MediaQuery.of(context).size.width / 360),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              "  Transactions",
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor(AppColors.blackTextColor),
                                  fontSize: 13.0 *
                                      MediaQuery.of(context).size.width /
                                      360),
                            ),
                            Text(
                              " (${AllData.schemeMap[widget.schemeKey]?.data.length})",
                              style: kGoogleStyleTexts.copyWith(
                                  color: hexToColor(AppColors.blackTextColor),
                                  fontSize: 11.0 *
                                      MediaQuery.of(context).size.width /
                                      360,
                                  fontWeight: FontWeight.w100),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerRight,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.all(Radius.circular(
                        //         10 * MediaQuery.of(context).size.width / 360),
                        //     ),
                        // ),
                        child: Row(
                          children: [
                            Text(
                              "Sort (By Date)",
                              style: kGoogleStyleTexts.copyWith(
                                  color:
                                      hexToColor(AppColors.investedValueMain),
                                  fontSize: 12.0 *
                                      MediaQuery.of(context).size.width /
                                      360),
                            ),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: AnimatedContainer(
                                margin: EdgeInsets.zero,
                                duration: const Duration(seconds: 3),
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform:
                                      Matrix4.rotationX(srt == '0' ? 0 : pi),
                                  child: Icon(
                                    Icons.sort,
                                    size: 12 *
                                        MediaQuery.of(context).size.width /
                                        360,
                                    color: hexToColor(AppColors
                                        .investedValueMain), //Colors.blueAccent,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  srt = (srt == '0') ? '1' : '0';
                                  // Navigator.of(context).pop();
                                });
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
            padding: EdgeInsets.zero,
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
                padding: EdgeInsets.symmetric(
                    vertical: 5.0 * MediaQuery.of(context).size.width / 360,
                    horizontal: 16 * MediaQuery.of(context).size.width / 360),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.transparent,
                  decoration: BoxDecoration(
                      color: hexToColor(
                          AppColors.whiteTextColor), //Colors.black11,
                      borderRadius: BorderRadius.all(Radius.circular(
                          10 * MediaQuery.of(context).size.width / 360))),
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: 08, vertical: 07),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                            5 * MediaQuery.of(context).size.width / 360),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 12 * MediaQuery.of(context).size.width / 360),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  12 * MediaQuery.of(context).size.width / 360),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Folio Number",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(item!.folioNumber.toString(),
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              if (item.transType != "Redemption")
                                Container(
                                  // width: 100 * MediaQuery.of(context).size.width / 360,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6.0 *
                                          MediaQuery.of(context).size.width /
                                          360,
                                      horizontal: 10 *
                                          MediaQuery.of(context).size.width /
                                          360),
                                  decoration: BoxDecoration(
                                      color: hexToColor(
                                              AppColors.installmentsBoxColor)
                                          .withOpacity(0.3),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360))),
                                  child: Text(
                                      "Installment ${item.installmentNumber.toString().padLeft(2, '0')}",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.installmentsColor),
                                          fontSize: 12.0 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: 10 * MediaQuery.of(context).size.width / 360,
                              right:
                                  12 * MediaQuery.of(context).size.width / 360,
                              left:
                                  12 * MediaQuery.of(context).size.width / 360),
                          // color: hexToColor(AppColors.installmentsBoxColor)
                          //     .withOpacity(0.3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Transaction Type",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(item.transType,
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.investedValueMain),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Amount",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontSize: 12.0 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(
                                      "\u{20B9} ${oCcy.format(item.amount).replaceFirst('.00', '')}",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.investedValueMain),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 4.0 * MediaQuery.of(context).size.width / 360,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildListRow(
                              context,
                              "Date",
                              formattedDate(item.date),
                            ),
                            buildListRow(
                                context, "Units", item.units.toString()),
                            buildListRow(context, "N.A.V", item.nav.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 10 * MediaQuery.of(context).size.width / 360,
          ),
        ],
      ),
    );
  }

  Widget buildListRow(BuildContext context, field, item) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 4.0 * MediaQuery.of(context).size.width / 360,
          horizontal: 12 * MediaQuery.of(context).size.width / 360),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(field,
              style: kGoogleStyleTexts.copyWith(
                  color: hexToColor(AppColors.investedValueMain),
                  fontSize: 12.0 * MediaQuery.of(context).size.width / 360),
              softWrap: true,
              textAlign: TextAlign.left),
          Text(item,
              style: kGoogleStyleTexts.copyWith(
                  color: hexToColor(AppColors.investedValueMain),
                  fontSize: 12.0 * MediaQuery.of(context).size.width / 360,
                  fontWeight: FontWeight.w600),
              softWrap: true,
              textAlign: TextAlign.left),
        ],
      ),
    );
  }

  Widget buildSummaryFieldRow(fieldName, value, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fieldName,
            style: kGoogleStyleTexts.copyWith(
                color: hexToColor(AppColors.mainCardField),
                fontSize: 12.0 * MediaQuery.of(context).size.width / 360),
          ),
          Text(
            value,
            style: kGoogleStyleTexts.copyWith(
                color: hexToColor(AppColors.mainCardField),
                fontWeight: FontWeight.w500,
                fontSize: 12.0 * MediaQuery.of(context).size.width / 360),
          ),
        ],
      ),
    );
  }

  Widget buildSummaryFieldColumnContainer(
    fieldName,
    value,
    go,
    context,
  ) {
    return Container(
      width: 100 * MediaQuery.of(context).size.width / 360,
      padding: EdgeInsets.symmetric(
          vertical: 6.0 * MediaQuery.of(context).size.width / 360,
          horizontal: 10 * MediaQuery.of(context).size.width / 360),
      decoration: BoxDecoration(
          color: hexToColor(AppColors.fieldColor).withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fieldName,
            style: kGoogleStyleTexts.copyWith(
                color: hexToColor(AppColors.fieldColor),
                fontWeight: FontWeight.w600,
                fontSize: 12.0 * MediaQuery.of(context).size.width / 360),
            softWrap: true,
          ),
          SizedBox(
            height: 2 * MediaQuery.of(context).size.width / 360,
          ),
          Text(
            value.toString(),
            style: kGoogleStyleTexts.copyWith(
                color: hexToColor(
                    go ? AppColors.greenAccent : AppColors.redAccent),
                fontWeight: FontWeight.w600,
                fontSize: 12.0 * MediaQuery.of(context).size.width / 360),
            softWrap: true,
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
