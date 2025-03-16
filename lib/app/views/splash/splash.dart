import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/images/app_images.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.put(SplashController());

    return Scaffold(
      body: Container(
        color: AppColors.appThemeColor, //const Color("#121212"),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.logo,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  Text(
                    "14 takka",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.loginBtnColor,
                        fontWeight: FontWeight.w800,
                        // textBaseline: TextBaseline.alphabetic,
                        fontSize: 35),
                  ),
                ],
              ),
            ),
            Obx(() {
              return splashController.showNetworkToast.value
                  ? Positioned.fill(
                      bottom: MediaQuery.of(context).size.height * 0.12,
                      // left: MediaQuery.of(context).size.height * 0.061,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedOpacity(
                          opacity: 1,
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            // height: 100,
                            width: MediaQuery.of(context).size.width * 0.75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.blackTextColor.withOpacity(0.8),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * 20 / 896,
                                vertical: MediaQuery.of(context).size.height * 20 / 896,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    AppImages.noInternet,
                                    height: 50,
                                    width: 50,
                                  ),
                                  Text(
                                    "No Internet Connection\nTry Again after some time.",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                          fontFamily: "inter",
                                          color: AppColors.whiteTextColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16.0 * (MediaQuery.of(context).size.width / 414),
                                          height: 1.5,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
