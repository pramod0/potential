// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:potential/app_assets_constants/AppColors.dart';
// import 'package:potential/models/token.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// //import 'package:shared_preferences/shared_preferences.dart';
//
// import '../ApiService.dart';
// import '../models/investments.dart';
// import '../utils/AllData.dart';
// import '../utils/appTools.dart';
// import '../utils/styleConstants.dart';
// import '../app_assets_constants/AppStrings.dart';
//
// import 'package:intl/intl.dart';
//
// final oCcy = NumberFormat("#,##0.00", "en_US");
//
// class SchemeSummaryScreen extends StatefulWidget {
//   var widget.schemeKey;
//   var widget.schemeCurrent;
//   SchemeSummaryScreen(
//       {super.key, required this.widget.schemeKey, required this.widget.schemeCurrent});
//
//   @override
//   State<SchemeSummaryScreen> createState() => _SchemeSummaryScreenState();
// }
//
// class _SchemeSummaryScreenState extends State<SchemeSummaryScreen> {
//   // List<Modal> userList = <Modal>[];
//   // final prefs = SharedPreferences.getInstance();
//   // String? totalRet = "0";
//   String sortFeature = "Current";
//   String srt = '0';
//   // late int totalFunds;
//
//
//   @override
//   void initState() {
//     // getData().whenComplete(() {
//     //   setState(() {});
//     // });
//     super.initState();
//   }
//
//   Future<bool> _onBackPressed() async {
//     Navigator.of(context).pop();
//     return false;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onBackPressed,
//       child: Scaffold(
//         backgroundColor:
//             hexToColor(AppColors.appThemeColor), //hexToColor("#121212"),
//         body: SafeArea(
//           child: buildMainDataScreen(context),
//         ),
//       ),
//     );
//   }
//
//   Column buildMainDataScreen(BuildContext context) {
//     return Column(
//       //crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//               left: 15.0, right: 15.0, top: 15.0, bottom: 0.0),
//           child: Column(
//             children: [
//               Column(
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         widget.widget.schemeCurrent.schemeName,
//                         style: kGoogleStyleTexts.copyWith(
//                             color: hexToColor(AppColors.blackTextColor)
//                                 .withOpacity(0.8),
//                             fontSize: 17.0,
//                             fontWeight: FontWeight.w700),
//                         textAlign: TextAlign.center,
//                       ),
//                       Text(
//                         '( ${widget.widget.schemeCurrent.fundName} )',
//                         style: kGoogleStyleTexts.copyWith(
//                             color: hexToColor(AppColors.blackTextColor)
//                                 .withOpacity(0.8),
//                             fontSize: 14.0),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Container(
//                     width: MediaQuery.of(context).size.width,
//                     decoration: const BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                     child: Card(
//                       shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(5)),
//                           side: BorderSide(
//                             width: 0.6,
//                             color: Colors.black26, //Colors.white30,
//                           )),
//                       borderOnForeground: true,
//                       color: hexToColor(AppColors
//                           .whiteTextColor), //Colors.transparent, //hexToColor("#1D1D1D"),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 20),
//                         child: Column(
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               // crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           AppStrings.invested,
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                       AppColors.blackTextColor)
//                                                   .withOpacity(0.65),
//                                               fontSize: 12.0),
//                                         ),
//                                         Text(
//                                           "\u{20B9}${oCcy.format(widget.widget.schemeCurrent.invested).replaceFirst('.00', '')}",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Container(
//                                               width: 4,
//                                               height: 4,
//                                               decoration: BoxDecoration(
//                                                 color: hexToColor(
//                                                     AppColors.currentValue),
//                                                 shape: BoxShape.circle,
//                                               ),
//                                             ),
//                                             Text(
//                                               " Total Returns",
//                                               style: kGoogleStyleTexts.copyWith(
//                                                   color: hexToColor(AppColors
//                                                           .blackTextColor)
//                                                       .withOpacity(0.65),
//                                                   fontSize: 12.0),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "+ \u{20B9}${oCcy.format(widget.widget.schemeCurrent.totalReturns)}",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                           softWrap: true,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 7,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           AppStrings.current,
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                       AppColors.blackTextColor)
//                                                   .withOpacity(0.65),
//                                               fontSize: 12.0),
//                                         ),
//                                         Text(
//                                           "\u{20B9}${oCcy.format(widget.widget.schemeCurrent.currentValue)}",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                         ),
//                                       ],
//                                     ),
//                                     // const SizedBox(
//                                     //   height: 10,
//                                     // // ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Container(
//                                               width: 4,
//                                               height: 4,
//                                               decoration: BoxDecoration(
//                                                 color: hexToColor(
//                                                     AppColors.currentValue),
//                                                 shape: BoxShape.circle,
//                                               ),
//                                             ),
//                                             Text(
//                                               " % Returns",
//                                               style: kGoogleStyleTexts.copyWith(
//                                                   color: hexToColor(AppColors
//                                                           .blackTextColor)
//                                                       .withOpacity(0.65),
//                                                   fontSize: 12.0),
//                                               softWrap: true,
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "${widget.widget.schemeCurrent.absReturns.toStringAsFixed(8).toString().substring(0, widget.widget.schemeCurrent.absReturns.toStringAsFixed(8).toString().length - 6)}%",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                           softWrap: true,
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 7,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             // Container(
//                                             //   width: 4,
//                                             //   height: 4,
//                                             //   decoration: BoxDecoration(
//                                             //     color: hexToColor(AppColors.currentValue),
//                                             //     shape: BoxShape.circle,
//                                             //   ),
//                                             // ),
//                                             Text(
//                                               "Total Units",
//                                               style: kGoogleStyleTexts.copyWith(
//                                                   color: hexToColor(AppColors
//                                                           .blackTextColor)
//                                                       .withOpacity(0.65),
//                                                   fontSize: 12.0),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "${widget.widget.schemeCurrent.unitHolding}",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                           softWrap: true,
//                                         ),
//                                       ],
//                                     ),
//                                     // const SizedBox(
//                                     //   height: 10,
//                                     // // ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Container(
//                                               width: 4,
//                                               height: 4,
//                                               decoration: BoxDecoration(
//                                                 color: hexToColor(
//                                                     AppColors.currentValue),
//                                                 shape: BoxShape.circle,
//                                               ),
//                                             ),
//                                             Text(
//                                               " Current NAV",
//                                               style: kGoogleStyleTexts.copyWith(
//                                                   color: hexToColor(AppColors
//                                                           .blackTextColor)
//                                                       .withOpacity(0.65),
//                                                   fontSize: 12.0),
//                                               softWrap: true,
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           widget.widget.schemeCurrent.currentNAV
//                                               .toString(),
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                           softWrap: true,
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 7,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             // Container(
//                                             //   width: 4,
//                                             //   height: 4,
//                                             //   decoration: BoxDecoration(
//                                             //     color: hexToColor(AppColors.currentValue),
//                                             //     shape: BoxShape.circle,
//                                             //   ),
//                                             // ),
//                                             Text(
//                                               "IRR",
//                                               style: kGoogleStyleTexts.copyWith(
//                                                   color: hexToColor(AppColors
//                                                           .blackTextColor)
//                                                       .withOpacity(0.65),
//                                                   fontSize: 12.0),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "${widget.widget.schemeCurrent.irr}%",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                           softWrap: true,
//                                         ),
//                                       ],
//                                     ),
//                                     // const SizedBox(
//                                     //   height: 10,
//                                     // // ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Container(
//                                               width: 4,
//                                               height: 4,
//                                               decoration: BoxDecoration(
//                                                 color: hexToColor(
//                                                     AppColors.currentValue),
//                                                 shape: BoxShape.circle,
//                                               ),
//                                             ),
//                                             Text(
//                                               " XIRR",
//                                               style: kGoogleStyleTexts.copyWith(
//                                                   color: hexToColor(AppColors
//                                                           .blackTextColor)
//                                                       .withOpacity(0.65),
//                                                   fontSize: 12.0),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "${widget.widget.schemeCurrent.xirr}%"
//                                               .toString(),
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 7,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             // Container(
//                                             //   width: 4,
//                                             //   height: 4,
//                                             //   decoration: BoxDecoration(
//                                             //     color: hexToColor(AppColors.currentValue),
//                                             //     shape: BoxShape.circle,
//                                             //   ),
//                                             // ),
//                                             Text(
//                                               "CAGR",
//                                               style: kGoogleStyleTexts.copyWith(
//                                                   color: hexToColor(AppColors
//                                                           .blackTextColor)
//                                                       .withOpacity(0.65),
//                                                   fontSize: 12.0),
//                                             ),
//                                           ],
//                                         ),
//                                         Text(
//                                           "${widget.widget.schemeCurrent.sinceDaysCAGR}%",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                           softWrap: true,
//                                         ),
//                                       ],
//                                     ),
//                                     // const SizedBox(
//                                     //   height: 10,
//                                     // // ),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           "Since",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                       AppColors.blackTextColor)
//                                                   .withOpacity(0.65),
//                                               fontSize: 12.0),
//                                           softWrap: true,
//                                         ),
//                                         Text(
//                                           "${widget.widget.schemeCurrent.sinceDays} days",
//                                           style: kGoogleStyleTexts.copyWith(
//                                               color: hexToColor(
//                                                   AppColors.blackTextColor),
//                                               fontSize: 16.0),
//                                           softWrap: true,
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Text(
//                 "Transactions",
//                 style: kGoogleStyleTexts.copyWith(
//                     color: hexToColor(AppColors.blackTextColor),
//                     fontSize: 15.0),
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: const BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.all(Radius.circular(10))),
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         children: [
//                           Text(
//                             AppStrings.investments,
//                             style: kGoogleStyleTexts.copyWith(
//                                 color: hexToColor(AppColors.blackTextColor),
//                                 fontSize: 15.0),
//                           ),
//                           Text(
//                             "(${AllData.schemeMap[widget.widget.schemeKey]?.data.length})",
//                             style: kGoogleStyleTexts.copyWith(
//                                 color: hexToColor(AppColors.blackTextColor),
//                                 fontSize: 13.0,
//                                 fontWeight: FontWeight.w100),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.centerRight,
//                       decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(10))),
//                       child: Row(
//                         children: [
//                           Text(
//                             "Sort",
//                             style: kGoogleStyleTexts.copyWith(
//                                 color: hexToColor(AppColors.blackTextColor),
//                                 fontSize: 17.0),
//                           ),
//                           IconButton(
//                             icon: AnimatedContainer(
//                               duration: const Duration(seconds: 3),
//                               child: Transform.rotate(
//                                 angle: srt == '0' ? 0 : 180 * 3.14 / 180,
//                                 child: Icon(
//                                   Icons.sort,
//                                   color: hexToColor(AppColors
//                                       .currentStatus), //Colors.blueAccent,
//                                 ),
//                               ),
//                             ),
//                             onPressed: () {
//                               showModalBottomSheet(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return buildBottomSheetContainerForSorting(
//                                       context);
//                                 },
//                               );
//                               //builderList
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Expanded(
//           child: ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.vertical,
//             itemCount: AllData.schemeMap[widget.widget.schemeKey]?.length,
//             itemBuilder: (context, i) {
//               final data = AllData.schemeMap[widget.widget.schemeKey]?.data.toList();
//               data?.sort((a, b) => (int.parse(srt) == 1
//                   ? a.date.toLowerCase().compareTo(b.date.toLowerCase())
//                   : b.date.toLowerCase().compareTo(a.date.toLowerCase())));
//               final item = data?[i];
//
//               return ListTile(
//                 title: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 4.0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     // color: Colors.transparent,
//                     decoration: BoxDecoration(
//                         color: hexToColor(
//                             AppColors.whiteTextColor), //Colors.black12,
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                     // padding: const EdgeInsets.symmetric(
//                     //     horizontal: 08, vertical: 07),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(5),
//                           ),
//                           border: Border.all(
//                             color: Colors.black26, //Colors.white24,
//                           )),
//                       padding: EdgeInsets.all(11),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Folio Number",
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                                   AppColors.blackTextColor)
//                                               .withOpacity(0.65),
//                                           fontSize: 12.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                   Text(item!.folioNumber.toString(),
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                               AppColors.blackTextColor),
//                                           fontSize: 16.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text("Installment No",
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                                   AppColors.blackTextColor)
//                                               .withOpacity(0.65),
//                                           fontSize: 12.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                   Text(item.installmentNumber.toString(),
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                               AppColors.blackTextColor),
//                                           fontSize: 16.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Transaction Type",
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                                   AppColors.blackTextColor)
//                                               .withOpacity(0.65),
//                                           fontSize: 12.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                   Text(item.transType,
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                               AppColors.blackTextColor),
//                                           fontSize: 16.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                 ],
//                               ),
//
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text("Amount",
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                                   AppColors.blackTextColor)
//                                               .withOpacity(0.65),
//                                           fontSize: 12.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                   Text(
//                                       "\u{20B9}${oCcy.format(item.amount).replaceFirst('.00', '')}",
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                               AppColors.blackTextColor),
//                                           fontSize: 16.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           const Divider(
//                             color: Colors.black26,
//                             //Colors.white70,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Date",
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                                   AppColors.blackTextColor)
//                                               .withOpacity(0.65),
//                                           fontSize: 12.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                   Text(item.date.replaceAll("-", "/"),
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                               AppColors.blackTextColor),
//                                           fontSize: 16.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Text("Units",
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                                   AppColors.blackTextColor)
//                                               .withOpacity(0.65),
//                                           fontSize: 12.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                   Text(item.units.toString(),
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                               AppColors.blackTextColor),
//                                           fontSize: 16.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                 ],
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text("N.A.V.",
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                                   AppColors.blackTextColor)
//                                               .withOpacity(0.65),
//                                           fontSize: 12.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                   Text(item.nav.toString(),
//                                       style: kGoogleStyleTexts.copyWith(
//                                           color: hexToColor(
//                                               AppColors.blackTextColor),
//                                           fontSize: 16.0),
//                                       softWrap: true,
//                                       textAlign: TextAlign.left),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Container buildBottomSheetContainerForSorting(BuildContext context) {
//     return Container(
//       color: hexToColor(AppColors.appThemeColor), //hexToColor("#121212"),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Select Order of sorting',
//                 style: kGoogleStyleTexts.copyWith(
//                     color: hexToColor(AppColors.blackTextColor),
//                     fontSize: 17.0),
//               ),
//             ),
//           ),
//           Column(
//             children: <Widget>[
//               RadioListTile(
//                 tileColor: hexToColor(AppColors.blackTextColor),
//                 title: Text(
//                   'Ascending',
//                   style: kGoogleStyleTexts.copyWith(
//                       color: hexToColor(AppColors.blackTextColor),
//                       fontSize: 17.0),
//                 ),
//                 value: "1",
//                 activeColor: hexToColor(AppColors.currentValue),
//                 groupValue: srt,
//                 onChanged: (value) {
//                   setState(() {
//                     srt = value.toString();
//                     Navigator.of(context).pop();
//                   });
//                 },
//                 controlAffinity: ListTileControlAffinity.trailing,
//               ),
//               RadioListTile(
//                 tileColor: hexToColor(AppColors.blackTextColor),
//                 title: Text(
//                   'Descending',
//                   style: kGoogleStyleTexts.copyWith(
//                       color: hexToColor(AppColors.blackTextColor),
//                       fontSize: 17.0),
//                 ),
//                 value: "0",
//                 activeColor: hexToColor(AppColors.currentValue),
//                 groupValue: srt,
//                 onChanged: (value) {
//                   setState(() {
//                     srt = value.toString();
//                     Navigator.of(context).pop();
//                   });
//                 },
//                 controlAffinity: ListTileControlAffinity.trailing,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Container buildBottomSheetContainerForFilters(BuildContext context) {
//   //   return Container(
//   //     color: hexToColor("#121212"),
//   //     child: Column(
//   //       mainAxisAlignment: MainAxisAlignment.center,
//   //       mainAxisSize: MainAxisSize.min,
//   //       children: <Widget>[
//   //         Align(
//   //           alignment: Alignment.centerLeft,
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(8.0),
//   //             child: Text(
//   //               'Sort Investments By',
//   //               style: kGoogleStyleTexts.copyWith(
//   //                   color: hexToColor(AppColors.blackTextColor),
//   //                   fontSize: 17.0),
//   //             ),
//   //           ),
//   //         ),
//   //         Column(
//   //           children: <Widget>[
//   //             RadioListTile(
//   //               title: Text(
//   //                 'Current',
//   //                 style: kGoogleStyleTexts.copyWith(
//   //                     color: hexToColor(AppColors.blackTextColor),
//   //                     fontSize: 17.0),
//   //               ),
//   //               selected: true,
//   //               activeColor: hexToColor("#45b6fe"),
//   //               value: "Current",
//   //               groupValue: sortFeature,
//   //               onChanged: (value) {
//   //                 setState(() {
//   //                   sortFeature = value.toString();
//   //                   srt = "0";
//   //                   Navigator.of(context).pop();
//   //                 });
//   //               },
//   //               controlAffinity: ListTileControlAffinity.trailing,
//   //             ),
//   //             RadioListTile(
//   //               title: Text(
//   //                 'Current',
//   //                 style: kGoogleStyleTexts.copyWith(
//   //                     color: hexToColor(AppColors.blackTextColor),
//   //                     fontSize: 17.0),
//   //               ),
//   //               selected: true,
//   //               activeColor: hexToColor("#45b6fe"),
//   //               value: "Invested",
//   //               groupValue: sortFeature,
//   //               onChanged: (value) {
//   //                 setState(() {
//   //                   sortFeature = value.toString();
//   //                   srt = "0";
//   //                   Navigator.of(context).pop();
//   //                 });
//   //               },
//   //               controlAffinity: ListTileControlAffinity.trailing,
//   //             ),
//   //             // RadioListTile(
//   //             //   title: Text(
//   //             //     '%XIRR',
//   //             //     style: kGoogleStyleTexts.copyWith(
//   //             //         color: hexToColor(AppColors.blackTextColor),
//   //             //         fontSize: 17.0),
//   //             //   ),
//   //             //   value: "%XIRR",
//   //             //   groupValue: sortFeature,
//   //             //   onChanged: (value) {
//   //             //     setState(() {
//   //             //       sortFeature = value.toString();
//   //             //       srt = "0";
//   //             //       Navigator.of(context).pop();
//   //             //     });
//   //             //   },
//   //             //   controlAffinity: ListTileControlAffinity.trailing,
//   //             // ),
//   //             // RadioListTile(
//   //             //   title: Text(
//   //             //     '%Returns',
//   //             //     style: kGoogleStyleTexts.copyWith(
//   //             //         color: hexToColor(AppColors.blackTextColor),
//   //             //         fontSize: 17.0),
//   //             //   ),
//   //             //   value: "%Returns",
//   //             //   groupValue: sortFeature,
//   //             //   onChanged: (value) {
//   //             //     setState(() {
//   //             //       sortFeature = value.toString();
//   //             //       srt = "0";
//   //             //       Navigator.of(context).pop();
//   //             //     });
//   //             //   },
//   //             //   controlAffinity: ListTileControlAffinity.trailing,
//   //             // ),
//   //             // RadioListTile(
//   //             //   title: Text(
//   //             //     'Alphabetical',
//   //             //     style: kGoogleStyleTexts.copyWith(
//   //             //         color: hexToColor(AppColors.blackTextColor),
//   //             //         fontSize: 17.0),
//   //             //   ),
//   //             //   value: "Alphabetical",
//   //             //   groupValue: sortFeature,
//   //             //   onChanged: (value) {
//   //             //     setState(() {
//   //             //       sortFeature = value.toString();
//   //             //       srt = "0";
//   //             //       Navigator.of(context).pop();
//   //             //     });
//   //             //   },
//   //             //   controlAffinity: ListTileControlAffinity.trailing,
//   //             // ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
//
// class ExitDialogue extends StatelessWidget {
//   const ExitDialogue({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//       backgroundColor:
//           hexToColor(AppColors.appThemeColor), //hexToColor("#101010"),
//       title: Text(
//         "Exit App",
//         style: kGoogleStyleTexts.copyWith(
//             color: hexToColor(AppColors.blackTextColor), fontSize: 18.0),
//       ),
//       content: Builder(
//         builder: (context) {
//           return SizedBox(
//             height: 100,
//             width: 200,
//             child: Column(
//               children: [
//                 Text(
//                   "Are you sure you want to exit the app?",
//                   style: kGoogleStyleTexts.copyWith(
//                       color: hexToColor(AppColors.blackTextColor),
//                       fontSize: 15.0),
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.only(left: 15, right: 15.0, top: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: 90,
//                         height: 45,
//                         child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor:
//                                     hexToColor(AppColors.blackTextColor),
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 side: const BorderSide(
//                                     width: 0.5, color: Colors.black26)),
//                             onPressed: () {
//                               Navigator.of(context).pop(false);
//                             },
//                             child: Text(
//                               "Cancel",
//                               style: kGoogleStyleTexts.copyWith(
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black54,
//                                 fontSize: 15.0,
//                               ),
//                             )),
//                       ),
//                       SizedBox(
//                         width: 90,
//                         height: 45,
//                         child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xffC93131),
//                                 elevation: 0,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0))),
//                             onPressed: () async {
//                               Navigator.pop(context, true);
//                             },
//                             child: Text(
//                               "Exit",
//                               style: kGoogleStyleTexts.copyWith(
//                                 fontWeight: FontWeight.w700,
//                                 color: hexToColor(AppColors.blackTextColor),
//                                 fontSize: 15.0,
//                               ),
//                             )),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// // class Modal {
// //   String name;
// //   bool isSelected;
// //
// //   Modal({required this.name, this.isSelected = false});
// // }

// import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
// import 'package:potential/models/token.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//import 'package:shared_preferences/shared_preferences.dart';

// import '../ApiService.dart';
// import '../models/investments.dart';
import '../utils/AllData.dart';
import '../utils/appTools.dart';
import '../utils/styleConstants.dart';
import '../app_assets_constants/AppStrings.dart';

import 'package:intl/intl.dart';

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
    return WillPopScope(
      onWillPop: () {
        return _onBackPressed(context);
      },
      child: Scaffold(
        backgroundColor:
            hexToColor(AppColors.appThemeColor), //hexToColor("#121212"),
        body: SafeArea(
          child: buildMainDataScreen(context),
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
                  Column(
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
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          side: BorderSide(
                            width: 0.6,
                            color: Colors.black26, //Colors.white30,
                          )),
                      borderOnForeground: true,
                      color: hexToColor(AppColors.whiteTextColor),
                      //Colors.transparent, //hexToColor("#1D1D1D"),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color: hexToColor(
                                                      AppColors.blackTextColor)
                                                  .withOpacity(0.65),
                                              fontSize: 12.0),
                                        ),
                                        Text(
                                          "\u{20B9}${oCcy.format(widget.schemeCurrent.invested).replaceFirst('.00', '')}",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
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
                                                  fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "+ \u{20B9}${oCcy.format(widget.schemeCurrent.totalReturns)}",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppStrings.current,
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                      AppColors.blackTextColor)
                                                  .withOpacity(0.65),
                                              fontSize: 12.0),
                                        ),
                                        Text(
                                          "\u{20B9}${oCcy.format(widget.schemeCurrent.currentValue)}",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
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
                                                  fontSize: 12.0),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${widget.schemeCurrent.absReturns.toStringAsFixed(8).toString().substring(0, widget.schemeCurrent.absReturns.toStringAsFixed(8).toString().length - 6)}%",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${widget.schemeCurrent.unitHolding}",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
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
                                                  fontSize: 12.0),
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
                                              fontSize: 16.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              "IRR",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: hexToColor(AppColors
                                                          .blackTextColor)
                                                      .withOpacity(0.65),
                                                  fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${widget.schemeCurrent.irr}%",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
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
                                              " XIRR",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: hexToColor(AppColors
                                                          .blackTextColor)
                                                      .withOpacity(0.65),
                                                  fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${widget.schemeCurrent.xirr}%"
                                              .toString(),
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              "CAGR",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: hexToColor(AppColors
                                                          .blackTextColor)
                                                      .withOpacity(0.65),
                                                  fontSize: 12.0),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "${widget.schemeCurrent.sinceDaysCAGR}%",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
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
                                        Text(
                                          "Since",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                      AppColors.blackTextColor)
                                                  .withOpacity(0.65),
                                              fontSize: 12.0),
                                          softWrap: true,
                                        ),
                                        Text(
                                          "${widget.schemeCurrent.sinceDays} days",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: hexToColor(
                                                  AppColors.blackTextColor),
                                              fontSize: 16.0),
                                          softWrap: true,
                                        ),
                                      ],
                                    )
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          Text(
                            "Sort",
                            style: kGoogleStyleTexts.copyWith(
                                color: hexToColor(AppColors.blackTextColor),
                                fontSize: 17.0),
                          ),
                          IconButton(
                            icon: AnimatedContainer(
                              duration: const Duration(seconds: 3),
                              child: Transform.rotate(
                                angle: srt == '0' ? 0 : 180 * 3.14 / 180,
                                child: Icon(
                                  Icons.sort,
                                  color: hexToColor(AppColors
                                      .currentStatus), //Colors.blueAccent,
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
        Expanded(
          child: AnimatedList(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            initialItemCount: AllData.schemeMap[widget.schemeKey]!.length,
            itemBuilder: (context, i, animation) {
              final data = AllData.schemeMap[widget.schemeKey]?.data.toList();
              data?.sort((a, b) => (int.parse(srt) == 1
                  ? a.date.toLowerCase().compareTo(b.date.toLowerCase())
                  : b.date.toLowerCase().compareTo(a.date.toLowerCase())));
              final item = data?[i];

              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: const Offset(0, 0),
                ).animate(animation),
                // CurvedAnimation(
                //   parent: _controller,
                //   curve: Curves.easeOutQuint,
                // ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 17),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.transparent,
                    decoration: BoxDecoration(
                        color: hexToColor(
                            AppColors.whiteTextColor), //Colors.black12,
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Folio Number",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(item!.folioNumber.toString(),
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontSize: 16.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Installment No",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(item.installmentNumber.toString(),
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontSize: 16.0),
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
                                          color: hexToColor(
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(item.transType,
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontSize: 16.0),
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
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(
                                      "\u{20B9}${oCcy.format(item.amount).replaceFirst('.00', '')}",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontSize: 16.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Date",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(item.date.replaceAll("-", "/"),
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontSize: 16.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Units",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(item.units.toString(),
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontSize: 16.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("N.A.V.",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                                  AppColors.blackTextColor)
                                              .withOpacity(0.65),
                                          fontSize: 12.0),
                                      softWrap: true,
                                      textAlign: TextAlign.left),
                                  Text(item.nav.toString(),
                                      style: kGoogleStyleTexts.copyWith(
                                          color: hexToColor(
                                              AppColors.blackTextColor),
                                          fontSize: 16.0),
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container buildBottomSheetContainerForSorting(BuildContext context) {
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
                activeColor: hexToColor(AppColors.currentValue),
                groupValue: srt,
                onChanged: (value) {
                  // setState(() {
                  //   srt = value.toString();
                  //   Navigator.of(context).pop();
                  // });
                  srt = value.toString();
                  Navigator.of(context).pop();
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
                activeColor: hexToColor(AppColors.currentValue),
                groupValue: srt,
                onChanged: (value) {
                  // setState(() {
                  //   srt = value.toString();
                  //   Navigator.of(context).pop();
                  // });
                  srt = value.toString();
                  Navigator.of(context).pop();
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
//     color: hexToColor("#121212"),
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

class ExitDialogue extends StatelessWidget {
  const ExitDialogue({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor:
          hexToColor(AppColors.appThemeColor), //hexToColor("#101010"),
      title: Text(
        "Exit App",
        style: kGoogleStyleTexts.copyWith(
            color: hexToColor(AppColors.blackTextColor), fontSize: 18.0),
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
                      color: hexToColor(AppColors.blackTextColor),
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
                                    hexToColor(AppColors.blackTextColor),
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
                                color: hexToColor(AppColors.blackTextColor),
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

// class Modal {
//   String name;
//   bool isSelected;
//
//   Modal({required this.name, this.isSelected = false});
// }
