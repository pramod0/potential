import 'package:flutter/material.dart';
import 'package:potential/utils/appTools.dart';

import '../../app_assets_constants/AppStrings.dart';
import '../../models/cancreation.dart';
import '../../utils/styleConstants.dart';

class VerifyMobileNum extends StatefulWidget {
  late CANIndFillEezzReq fillEezzReq;
  VerifyMobileNum({Key? key, required this.fillEezzReq}) : super(key: key);

  @override
  State<VerifyMobileNum> createState() => _CreateVerifyMobileNum();
}

class _CreateVerifyMobileNum extends State<VerifyMobileNum> {
  final maxLines = 2;
  final TextEditingController mobileNOController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: hexToColor("#121212"),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.mobileNO,
                  style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: hexToColor("#ffffff"),
                  ),
                )),
          ),
          SizedBox(
            height: maxLines * 25.0,
            child: TextFormField(
                textInputAction: TextInputAction.next,
                controller: mobileNOController,
                initialValue: widget.fillEezzReq.rEQBODY?.hOLDERRECORDS
                    ?.hOLDERRECORD?.cONTACTDETAIL?.pRIMOBNO
                    .toString(),
                onSaved: (val) => mobileNOController.text = val!,
                keyboardType: TextInputType.number,
                style: kGoogleStyleTexts.copyWith(
                    fontWeight: FontWeight.w400,
                    color: hexToColor("#0065A0"),
                    fontSize: 15.0),
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: hexToColor("#0065A0"),
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: hexToColor("#0065A0"))),
                  fillColor: const Color.fromARGB(30, 173, 205, 219),
                  filled: true,
                  hintText: AppStrings.mobileNO,
                  hintStyle: kGoogleStyleTexts.copyWith(
                      color: hexToColor("#5F93B1"),
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
                )),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
