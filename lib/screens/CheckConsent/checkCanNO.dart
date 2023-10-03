import 'package:flutter/material.dart';

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
    return const Scaffold(
      body: Center(
        child: Text(
          "Please Contact the support Team as you are not a registered user here.",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
