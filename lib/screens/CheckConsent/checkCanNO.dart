import 'package:flutter/material.dart';
import 'package:potential/app_assets_constants/AppColors.dart';
import 'package:potential/app_assets_constants/AppStrings.dart';
import 'package:potential/utils/appTools.dart';

import '../../utils/styleConstants.dart';

class CheckCANNO extends StatefulWidget {
  const CheckCANNO({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StateCheckCANNO();
  }
}

class _StateCheckCANNO extends State<CheckCANNO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor(AppColors.appThemeColorAppBar),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            AppStrings.pleaseRegisterText,
            style: kGoogleStyleTexts.copyWith(
                color: hexToColor(
                    AppColors.blackTextColor), //hexToColor("#ffffff"),
                fontSize: 15,
                fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
