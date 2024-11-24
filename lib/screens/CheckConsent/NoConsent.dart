import 'package:flutter/material.dart';
import 'package:potential/app_assets_constants/AppColors.dart';

class TakeConsentPage extends StatefulWidget {
  const TakeConsentPage({
    super.key,
    this.can,
    this.pan,
  });

  final can, pan;

  @override
  State<StatefulWidget> createState() {
    return _StateCheckCANNO();
  }
}

class _StateCheckCANNO extends State<TakeConsentPage> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  showSnackBar(String text, Color color) {
    _scaffoldKey.currentState
        ?.showSnackBar(SnackBar(content: Text(text), backgroundColor: color));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF28282B),
      appBar: AppBar(
        title: const Text("Consent Page"),
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Center(
              child: Text(
                "Please Provide the details so that the Association can access your data to display it within the application.",
                style: TextStyle(fontSize: 20, color: AppColors.blackTextColor),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Common Account Number(CAN)",
              style: TextStyle(fontSize: 20, color: AppColors.blackTextColor),
            ),
            TextField(
              controller: TextEditingController(text: widget.can),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Permanaent Account Number(PAN)",
              style: TextStyle(fontSize: 20, color: AppColors.blackTextColor),
            ),
            TextField(
              controller: TextEditingController(text: widget.pan),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Mobile Number",
              style: TextStyle(fontSize: 20, color: AppColors.blackTextColor),
            ),
            const TextField(),
            ElevatedButton(
                onPressed: () {
                  showSnackBar("Added Consent Application Wait for few minutes",
                      Colors.red);
                },
                child: const Text("Submit")),
          ],
        ),
      ),
    );
  }
}
