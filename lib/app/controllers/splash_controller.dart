import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:potential/app/services/local_storage/secure_storage.dart';
import 'package:potential/app/services/native/service/network_status.dart';

import '../../models/token.dart';
import '../../navigation/app_routes.dart';

//off : pushReplacedNamed
//to : pushNamed
//back: pop
//until: popUntil

class SplashController extends GetxController {
  RxBool showNetworkToast = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoggedIn();
  }

  Future<void> isLoggedIn() async {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    // TODO:
    //check for biometric data in local if not then go ahed
    //if yes then authenticate if no then go login and wait then go further
    // if not //go to login //
    //check local persistence:get all possible data for login and first page
    String? token = await SecureStorageService().getValue("token");
    if (token != null || token != "") {
      Map<String, dynamic> expired = {};
      try {
        expired = JwtDecoder.decode(token!);
      } catch (e) {
        //TODO: if not //go to login //
      }
      if (expired.isNotEmpty) {
        int h =
            DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(expired['exp'] * 1000, isUtc: true)).inHours;
        if (h < 0) {
          bool connectionResult = await NetworkStatusService().isServiceEnabled();
          if (!connectionResult) {
            showNetworkToast.value = true;
            //TODO: show pop
            showNetworkToast.value = false;
            Get.clearRouteTree();
            SystemNavigator.pop(animated: true);
            return;
          }
          //if good to go
          //add token to singleton
          Token(token!);
          Get.to(AppRoutes.dashboard);
          //get dashboard data
          //get scheme data
          //go dashboard
          return;
        }
      }
    }

    Get.to(AppRoutes.login);
    await EasyLoading.dismiss();
    return;
  }
}
