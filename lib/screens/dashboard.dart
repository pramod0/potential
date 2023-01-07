import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:potential/models/investor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/appTools.dart';
import '../util/styleConstants.dart';
import 'login.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Modal> userList = <Modal>[];
  final prefs = SharedPreferences.getInstance();
  Investor? investorData;
  String? totalRet = "0";
  String gender = "Current";
  String srt = '1';
  late int totalFunds;

  Future<String> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? studentJson = pref.getString('investorData');
    investorData = Investor.fromJson(jsonDecode(studentJson!));
    if (kDebugMode) {
      String? c = (investorData?.investmentData?.current);
      String? d = (investorData?.investmentData?.invested);
      totalRet = (int.parse(c!) + int.parse(d!)).toString();
    }
    return Future.value("Data Downloaded Successfully");
  }

  @override
  void initState() {
    getData().whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const ExitDialogue()) ??
        false;
  }

  _iconControl(bool like) {
    if (like == false) {
      return const Icon(Icons.favorite_border);
    } else {
      return const Icon(
        Icons.favorite,
        color: Colors.red,
      );
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 0.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "Investments",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white, fontSize: 15.0),
                                ),
                                Text(
                                  "(${investorData?.investmentData?.fundData?.length})",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white70,
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
                            color: hexToColor("#1D1D1D"),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Invested",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: Colors.white70,
                                                  fontSize: 12.0),
                                            ),
                                            Text(
                                              "${investorData?.investmentData?.invested}",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Current",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: Colors.white70,
                                                  fontSize: 12.0),
                                            ),
                                            Text(
                                              "${investorData?.investmentData?.current}",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 15.0),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 4,
                                                  height: 4,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        hexToColor("#FCAF23"),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                                Text(
                                                  " Total Returns",
                                                  style: kGoogleStyleTexts
                                                      .copyWith(
                                                          color: Colors.white70,
                                                          fontSize: 12.0),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "\u{20B9} ${totalRet!}",
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 15.0),
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
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: [
                              Text(
                                "Sort",
                                style: kGoogleStyleTexts.copyWith(
                                    color: Colors.white70,
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
                                      return Container(
                                        color: hexToColor("#121212"),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Select Order of sorting',
                                                  style: kGoogleStyleTexts.copyWith(
                                                      color: Colors.white70,
                                                      fontSize: 17.0),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                RadioListTile(
                                                  title: Text(
                                                    'Ascending',
                                                    style:
                                                        kGoogleStyleTexts.copyWith(
                                                            color: Colors.white70,
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
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .trailing,
                                                ),
                                                RadioListTile(
                                                  title: Text(
                                                    'Descending',
                                                    style:
                                                        kGoogleStyleTexts.copyWith(
                                                            color: Colors.white70,
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
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .trailing,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
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
                                "Current ($gender)",
                                style: kGoogleStyleTexts.copyWith(
                                    color: Colors.white70, fontSize: 12.0),
                              ),
                            ],
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
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
                                                color: Colors.white70,
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
                                                  color: Colors.white70,
                                                  fontSize: 17.0),
                                            ),
                                            selected: true,
                                            activeColor: hexToColor("#45b6fe"),
                                            value: "Current",
                                            groupValue: gender,
                                            onChanged: (value) {
                                              setState(() {
                                                gender = value.toString();
                                                srt = "0";
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                          RadioListTile(
                                            title: Text(
                                              '%xiir',
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: Colors.white70,
                                                  fontSize: 17.0),
                                            ),
                                            value: "%xiir",
                                            groupValue: gender,
                                            onChanged: (value) {
                                              setState(() {
                                                gender = value.toString();
                                                srt = "0";
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                          RadioListTile(
                                            title: Text(
                                              '%returns',
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: Colors.white70,
                                                  fontSize: 17.0),
                                            ),

                                            value: "%returns",
                                            groupValue: gender,
                                            onChanged: (value) {
                                              setState(() {
                                                gender = value.toString();
                                                srt = "0";
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                          RadioListTile(
                                            title: Text(
                                              'Alphabetical',
                                              style: kGoogleStyleTexts.copyWith(
                                                  color: Colors.white70,
                                                  fontSize: 17.0),
                                            ),
                                            value: "Alphabetical",
                                            groupValue: gender,
                                            onChanged: (value) {
                                              setState(() {
                                                gender = value.toString();
                                                srt = "0";
                                                Navigator.of(context).pop();
                                              });
                                            },
                                            controlAffinity:
                                                ListTileControlAffinity
                                                    .trailing,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                //scrollDirection: Axis.vertical,
                itemCount: investorData?.investmentData?.fundData?.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.symmetric(horizontal: 05),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Text(
                                    "${investorData?.investmentData?.fundData![i].fundName!}\nRegular Growth",
                                    style: kGoogleStyleTexts.copyWith(
                                        color: Colors.white70, fontSize: 15.0),
                                    //softWrap: true,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "\u{20B9} ${investorData?.investmentData?.fundData![i].current!}",
                                    style: kGoogleStyleTexts.copyWith(
                                        color: Colors.blueAccent[400],
                                        fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "(\u{20B9} ${investorData?.investmentData?.fundData![i].invested!})",
                              style: kGoogleStyleTexts.copyWith(
                                  color: Colors.white70, fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
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
        style: kGoogleStyleTexts.copyWith(color: Colors.white, fontSize: 18.0),
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
                      color: Colors.white, fontSize: 15.0),
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
                                backgroundColor: Colors.white,
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
                              // SharedPreferences prefs =
                              //     await SharedPreferences.getInstance();
                              // //Return String
                              // prefs.clear();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Login()));
                            },
                            child: Text(
                              "Exit",
                              style: kGoogleStyleTexts.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
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

class AppStrings {
  static const String total = "Total";
  static const String current = 'Current';
  static const String invested = 'Invested';
  static const String dashboardText = "Dashboard";
}
