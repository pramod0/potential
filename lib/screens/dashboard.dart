import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/app_assets_constants/AppImages.dart';
import 'package:potential/models/token.dart';
import 'package:potential/screens/graph_page.dart';
import 'package:potential/screens/profile_page.dart';
import 'package:potential/screens/schemeSummaryScreen.dart';
import 'package:potential/screens/sip_calculator.dart';
import 'package:provider/provider.dart';
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
    ScaffoldMessenger.of(context).showMaterialBanner(banner);
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
    _getVersion();
    super.initState();
  }

  String _version = "0.0.0";

  Future<void> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _version = "${packageInfo.version}+${packageInfo.buildNumber}";
      if (kDebugMode) {
        print(_version);
      }
    });
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
          //  irr: 0,
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
                  hexToColor(AppColors.homeBG), //hexToColor("#121212"),
              title: Text(
                "Dashboard",
                style: kGoogleStyleTexts.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20 * MediaQuery.of(context).size.width / 360,
                  color: hexToColor(AppColors.blackTextColor),
                ),
              ),
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
            ),
            // drawerDragStartBehavior: DragStartBehavior.start,
            drawer: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              decoration: BoxDecoration(
                color: hexToColor(AppColors.homeBG),
              ),
              padding: EdgeInsets.zero,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height * 0.20,
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.shade200.withOpacity(0.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                          ],
                        ),
                      ),
                      ListTile(
                        tileColor: hexToColor(AppColors.homeBG),
                        leading: const Icon(Icons.person_rounded),
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
                                builder: (context) => const ProfilePage())),
                      ),
                      ListTile(
                          tileColor: hexToColor(AppColors.homeBG),
                          leading: const Icon(Icons.auto_graph),
                          title: Text(
                            "Investment Analysis",
                            style: kGoogleStyleTexts.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: hexToColor(AppColors.blackTextColor),
                            ),
                          ),
                          onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider(
                                            lazy: true,
                                            create:
                                                (context) =>
                                                    InvestmentDataProvider(),
                                            child:
                                                const GraphAnalysisScreen())))
                              }),
                      ListTile(
                        tileColor: hexToColor(AppColors.homeBG),
                        leading: const Icon(Icons.calculate_rounded),
                        title: Text(
                          "SIP Calculator",
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: hexToColor(AppColors.blackTextColor),
                          ),
                        ),
                        onTap: () => {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                    lazy: true,
                                    create: (context) => WealthProvider(),
                                    child: const SipCalculator())),
                          )
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ListTile(
                        tileColor: hexToColor(AppColors.homeBG),
                        leading: const Icon(Icons.logout_outlined),
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
                      const Divider(),
                      ListTile(
                        leading: const SizedBox.shrink(),
                        title: Text(
                          'version: $_version',
                          style: kGoogleStyleTexts.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: hexToColor(AppColors.blackTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            backgroundColor: hexToColor(AppColors.homeBG),
            body: AllData.investedData.fundData.isNotEmpty
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
            padding: EdgeInsets.only(
              top: 7.5 * MediaQuery.of(context).size.width / 360,
              left: 15.0 * MediaQuery.of(context).size.width / 360,
              right: 15.0 * MediaQuery.of(context).size.width / 360,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: kGoogleStyleTexts.copyWith(
                          color: hexToColor(AppColors.currentValueText),
                          fontSize:
                              12.0 * MediaQuery.of(context).size.width / 360,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${AllData.investorData.firstName?.trim()} ${AllData.investorData.lastName?.trim()}",
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.currentValueText),
                              fontSize: 16.0 *
                                  MediaQuery.of(context).size.width /
                                  360,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 7 * MediaQuery.of(context).size.width / 360,
                      bottom: 10 * MediaQuery.of(context).size.width / 360),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          AppStrings.investments,
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.currentValueText),
                              fontSize: 12.0 *
                                  MediaQuery.of(context).size.width /
                                  360,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          " (${AllData.investedData.fundData.length})",
                          style: kGoogleStyleTexts.copyWith(
                              color: hexToColor(AppColors.fieldColor),
                              fontSize: 10.0 *
                                  MediaQuery.of(context).size.width /
                                  360,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  surfaceTintColor: hexToColor(AppColors.whiteTextColor),
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(
                          8 * MediaQuery.of(context).size.width / 360)),
                      side: BorderSide(
                        width: 1 * MediaQuery.of(context).size.width / 360,
                        color: hexToColor("#2196F3")
                            .withOpacity(0.2), //Colors.white30,
                      )),
                  borderOnForeground: true,
                  color:
                      hexToColor(AppColors.contrastContainer).withOpacity(0.6),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        surfaceTintColor: hexToColor(AppColors.whiteTextColor),
                        margin: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  8 * MediaQuery.of(context).size.width / 360),
                              topRight: Radius.circular(
                                  8 * MediaQuery.of(context).size.width / 360)),
                        ),
                        borderOnForeground: true,
                        color: hexToColor(AppColors.contrastContainer)
                            .withOpacity(0.6),
                        //Colors.black.withOpacity(0.25),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 8 * MediaQuery.of(context).size.width / 360,
                              bottom:
                                  6 * MediaQuery.of(context).size.width / 360,
                              left:
                                  12 * MediaQuery.of(context).size.width / 360,
                              right:
                                  12 * MediaQuery.of(context).size.width / 360),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Current Value",
                                    style: kGoogleStyleTexts.copyWith(
                                      color: hexToColor(
                                          AppColors.currentValueText),
                                      fontSize: 12.0 *
                                          MediaQuery.of(context).size.width /
                                          360,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "\u{20B9} ${oCcy.format(AllData.investedData.current)}",
                                        style: kGoogleStyleTexts.copyWith(
                                            color: hexToColor(
                                                AppColors.currentValue),
                                            fontSize: 20.0 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                360,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        surfaceTintColor: hexToColor(AppColors.whiteTextColor),
                        margin: EdgeInsets.zero,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                        borderOnForeground: true,
                        color: hexToColor(AppColors.whiteTextColor),
                        //Colors.black.withOpacity(0.25),
                        child: Padding(
                          padding: EdgeInsets.all(
                              12 * MediaQuery.of(context).size.width / 360),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                        buildInvested(context),
                                        SizedBox(
                                          height: 12 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              360,
                                        ),
                                        buildTotalReturns(context),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // buildAbsReturns(context),
                                      buildXIRR(context),
                                      SizedBox(
                                        height: 12 *
                                            MediaQuery.of(context).size.width /
                                            360,
                                      ),
                                      buildCAGR(context),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
                horizontal: 20 * MediaQuery.of(context).size.width / 360),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Sort",
                      style: kGoogleStyleTexts.copyWith(
                          color: hexToColor(AppColors.investedValueMain),
                          fontSize:
                              11.0 * MediaQuery.of(context).size.width / 360,
                          fontWeight: FontWeight.w500),
                    ),
                    // IconButton(
                    //   // icon: AnimatedContainer(
                    //   //   duration: const Duration(seconds: 3),
                    //   //   child: Transform.rotate(
                    //   //     angle: srt == '0' ? 0 : 180 * 3.14 / 180,
                    //   //     child: Icon(
                    //   //       Icons.sort,
                    //   //       color: hexToColor(AppColors.loginBtnColor)
                    //   //           .withOpacity(0.6),
                    //   //     ),
                    //   //   ),
                    //   // ),
                    //   alignment: Alignment.center,
                    //   icon: Icon(
                    //     srt != '0'
                    //         ? Icons.arrow_downward_outlined
                    //         : Icons.arrow_upward_outlined,
                    //     size: 16 * MediaQuery.of(context).size.width / 360,
                    //     color: hexToColor(AppColors.investedValueMain),
                    //   ),
                    //   onPressed: () {
                    //     setState(() {
                    //       srt = (srt == '0') ? '1' : '0';
                    //       // Navigator.of(context).pop();
                    //     });
                    //     // WidgetsBinding.instance
                    //     //     .addPostFrameCallback((_) => );
                    //     // showModalBottomSheet(
                    //     //   context: context,
                    //     //   builder: (BuildContext context) {
                    //     //     return buildBottomSheetContainerForSorting(context);
                    //     //   },
                    //     // );
                    //     //builderList
                    //   },
                    // ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: AnimatedContainer(
                        margin: EdgeInsets.zero,
                        duration: const Duration(seconds: 3),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationX(srt == '0' ? 0 : pi),
                          child: Icon(
                            Icons.sort,
                            size: 12 * MediaQuery.of(context).size.width / 360,
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
                      Image.asset(
                        AppImages.current,
                        height: 16 * MediaQuery.of(context).size.width / 360,
                      ),
                      SizedBox(
                        width: 4 * MediaQuery.of(context).size.width / 360,
                      ),
                      Text(
                        "Current ($sortFeature)",
                        style: kGoogleStyleTexts.copyWith(
                            color: hexToColor(AppColors.blackTextColor),
                            fontSize:
                                11.0 * MediaQuery.of(context).size.width / 360),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
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
              } else if (sortFeature == "Start Date") {
                data.sort((a, b) => (int.parse(srt) == 1
                    ? a.sinceDate.compareTo(b.sinceDate)
                    : b.sinceDate.compareTo(a.sinceDate)));
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

              return Padding(
                padding: EdgeInsets.only(
                    left: 16 * MediaQuery.of(context).size.width / 360,
                    right: 16 * MediaQuery.of(context).size.width / 360,
                    bottom: 10 * MediaQuery.of(context).size.width / 360),
                child: InkWell(
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
                  child: Container(
                    decoration: BoxDecoration(
                        color: hexToColor(AppColors.whiteTextColor),
                        borderRadius: BorderRadius.all(Radius.circular(
                            6 * MediaQuery.of(context).size.width / 360))),
                    padding: EdgeInsets.all(
                        12 * MediaQuery.of(context).size.width / 360),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              padding: EdgeInsets.symmetric(
                                  vertical: 2 *
                                      MediaQuery.of(context).size.width /
                                      360),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5 *
                                          MediaQuery.of(context).size.width /
                                          360))),
                              child: Text(item.schemeName,
                                  style: kGoogleStyleTexts.copyWith(
                                      color: hexToColor(AppColors.schemeColor),
                                      fontSize: 14.0 *
                                          MediaQuery.of(context).size.width /
                                          360,
                                      fontWeight: FontWeight.w600),
                                  softWrap: true,
                                  textAlign: TextAlign.left),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Text("Since",
                                //     style: kGoogleStyleTexts.copyWith(
                                //         color: hexToColor(AppColors.fieldColor),
                                //         fontSize: 12.0 *
                                //             MediaQuery.of(context).size.width /
                                //             360,
                                //         height: 2 *
                                //             MediaQuery.of(context).size.width /
                                //             360,
                                //         fontWeight: FontWeight.w600),
                                //     softWrap: true,
                                //     textAlign: TextAlign.right),
                                Text(formattedDate(item.sinceDate),
                                    style: kGoogleStyleTexts.copyWith(
                                        color: hexToColor(AppColors.fieldColor),
                                        fontSize: 12.0 *
                                            MediaQuery.of(context).size.width /
                                            360,
                                        height: 2 *
                                            MediaQuery.of(context).size.width /
                                            360,
                                        fontWeight: FontWeight.w500),
                                    softWrap: true,
                                    textAlign: TextAlign.right),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          color: hexToColor(AppColors.fieldColor)
                              .withOpacity(0.2), //Colors.white30,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // color: Colors.orangeAccent,
                              // width:
                              //     85 * MediaQuery.of(context).size.width / 360,
                              padding: EdgeInsets.zero,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SubHeadingText(item: "Gains/Loss"),
                                  SizedBox(
                                    height: 6 *
                                        MediaQuery.of(context).size.width /
                                        360,
                                  ),
                                  // ValueText(
                                  //     item:
                                  //         "${item.absReturns > 0.0 ? "+" : ""} ${item.absReturns}%",
                                  //     color:
                                  ValueText(
                                      item: (item.totalReturns < 100000)
                                          ? "${AppStrings.rupeeSign} ${oCcy.format(item.totalReturns / 1000).contains('.00') ? oCcy.format(item.totalReturns / 1000).replaceAll('.00', '') : oCcy.format(item.totalReturns / 1000)} K"
                                          : "${AppStrings.rupeeSign} ${oCcy.format(item.totalReturns / 100000).contains('.00') ? oCcy.format(item.totalReturns / 100000).replaceAll('.00', '') : oCcy.format(item.totalReturns / 100000)} L",
                                      color:
                                          getConditionalColor(item.absReturns))
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 12 *
                                    MediaQuery.of(context).size.width /
                                    360,
                              ),
                              // color: Colors.redAccent,
                              // width:
                              //     108 * MediaQuery.of(context).size.width / 360,
                              // padding: EdgeInsets.zero,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SubHeadingText(item: "Invested"),
                                  SizedBox(
                                    height: 6 *
                                        MediaQuery.of(context).size.width /
                                        360,
                                  ),
                                  ValueText(
                                      item: (item.invested < 100000)
                                          ? "${AppStrings.rupeeSign} ${oCcy.format(item.invested / 1000).contains('.00') ? oCcy.format(item.invested / 1000).replaceAll('.00', '') : oCcy.format(item.invested / 1000)} K"
                                          : "${AppStrings.rupeeSign} ${oCcy.format(item.invested / 100000).contains('.00') ? oCcy.format(item.invested / 100000).replaceAll('.00', '') : oCcy.format(item.invested / 100000)} L",
                                      color: AppColors.investedValueMain)
                                ],
                              ),
                            ),
                            // Spacer(),
                            Container(
                              padding: EdgeInsets.only(
                                left: 12 *
                                    MediaQuery.of(context).size.width /
                                    360,
                              ),
                              // color: Colors.redAccent,
                              // width:
                              //     108 * MediaQuery.of(context).size.width / 360,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SubHeadingText(item: "Current"),
                                  SizedBox(
                                    height: 6 *
                                        MediaQuery.of(context).size.width /
                                        360,
                                  ),
                                  ValueText(
                                      item: (item.currentValue < 100000)
                                          ? "${AppStrings.rupeeSign} ${oCcy.format(item.currentValue / 1000).contains('.00') ? oCcy.format(item.currentValue / 1000).replaceAll('.00', '') : oCcy.format(item.currentValue / 1000)} K"
                                          : "${AppStrings.rupeeSign} ${oCcy.format(item.currentValue / 100000).contains('.00') ? oCcy.format(item.currentValue / 100000).replaceAll('.00', '') : oCcy.format(item.currentValue / 100000)} L",
                                      color: AppColors.investedValueMain),
                                ],
                              ),
                            ),
                            // const Spacer(),
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

  String getConditionalColor(item) {
    return item == 0.0
        ? AppColors.investedValueMain
        : (item > 0.0 ? AppColors.greenAccent : AppColors.redAccent);
  }

  Column buildXIRR(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildMainCardField(context, "XIRR"),
        Text(
          "${AllData.investedData.xirr > 0.0 ? "+ " : ""}${AllData.investedData.xirr.toStringAsFixed(2)}%"
              .toString(),
          style: kGoogleStyleTexts.copyWith(
            color: hexToColor(getConditionalColor(AllData.investedData.xirr)),
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
            color: hexToColor(
                getConditionalColor(AllData.investedData.totalReturns)),
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
        Row(
          children: [
            Text(
              "${AllData.investedData.totalReturns > 0.0 ? "+ " : ""}${AppStrings.rupeeSign} ${oCcy.format(AllData.investedData.totalReturns)}",
              style: kGoogleStyleTexts.copyWith(
                color: hexToColor(
                    getConditionalColor(AllData.investedData.totalReturns)),
                fontWeight: FontWeight.w500,
                fontSize: 14.0 * MediaQuery.of(context).size.width / 360,
              ),
              softWrap: true,
            ),
            Text(
              " (${AllData.investedData.absReturns > 0.0 ? (AllData.investedData.absReturns) : (AllData.investedData.absReturns * -1)}%)",
              textAlign: TextAlign.end,
              style: kGoogleStyleTexts.copyWith(
                color: hexToColor(
                    getConditionalColor(AllData.investedData.totalReturns)),
                fontWeight: FontWeight.w500,
                fontSize: 11.0 * MediaQuery.of(context).size.width / 360,
              ),
              softWrap: true,
            ),
          ],
        ),
      ],
    );
  }

  Column buildCAGR(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildMainCardField(context, "CAGR"),
        Text(
          "${AllData.investedData.sinceDaysCAGR > 0.0 ? "+ " : ""}${(AllData.investedData.sinceDaysCAGR)}%",
          style: kGoogleStyleTexts.copyWith(
            color: hexToColor(
                getConditionalColor(AllData.investedData.sinceDaysCAGR)),
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
                                            "${AppStrings.rupeeSign}----",
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
                                            "${AppStrings.rupeeSign}----",
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
                                                "+ ${AppStrings.rupeeSign}---- ",
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
                  'Start Date',
                  style: kGoogleStyleTexts.copyWith(
                      color: hexToColor(AppColors.blackTextColor),
                      fontSize: 14.0),
                ),
                selected: true,
                activeColor: hexToColor(AppColors.loginBtnColor),
                value: "Start Date",
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

  final String item;

  @override
  Widget build(BuildContext context) {
    return Text(item,
        style: kGoogleStyleTexts.copyWith(
            color: hexToColor(AppColors.fieldColor),
            fontSize: 14.0 * MediaQuery.of(context).size.width / 360,
            fontWeight: FontWeight.w600),
        softWrap: true,
        textAlign: TextAlign.right);
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
          fontWeight: FontWeight.w500,
          color: hexToColor(color),
          fontSize: 14.0 * MediaQuery.of(context).size.width / 360),
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
