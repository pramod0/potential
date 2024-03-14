import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandedElevatedButton extends StatelessWidget {
  final onPressed;

  // final Color buttonColor;
  final String textToShow;

  // final Color textColor;

  const ExpandedElevatedButton({
    super.key,
    required this.onPressed,
    // required this.buttonColor,
    required this.textToShow,
    // required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
          // style: ButtonStyle(
          //   backgroundColor: MaterialStateProperty.all(buttonColor),
          // ),
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(
              32 / 896 * MediaQuery.of(context).size.height),
          color: CupertinoColors.systemBlue.withOpacity(0.1),
          onPressed: onPressed,
          child: Text(
            textToShow,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'inter',
              color: Colors.blueAccent,
              fontSize: 18.0 / 896 * MediaQuery.of(context).size.height,
              height: 1.5,
            ),
          )),
    );
  }
}
