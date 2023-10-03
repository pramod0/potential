import 'package:flutter/material.dart';

class ConsentNoData extends StatefulWidget {
  const ConsentNoData({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StateConsentNoData();
  }
}

class _StateConsentNoData extends State<ConsentNoData> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "We appreciate that you have given the consent, but it takes a day or some times more time to fetch all your transactions Data. Most Probably the next day only the data Comes",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
