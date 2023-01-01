import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _showPassword = false;
  final maxLines = 2;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  late String _username;
  late String _password;

  final TextEditingController userNameController =
  TextEditingController(text: ""); // for quick testing
  final TextEditingController passwordController =
  TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: hexToColor("#F5F5F5"),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Align(
                          alignment:Alignment.centerLeft,
                          child: Card(

                            child: Text(
                              AppStrings.loginNowText,
                            ),
                          ),
                        ),
                        Text(
                          "Please Login with your credentials",
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStrings.userName,
                      style: kGoogleStyleTexts.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: maxLines * 25.0,
                            child: TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: userNameController,
                                onSaved: (val) => _username = val!,
                                keyboardType: TextInputType.emailAddress,
                                style: kGoogleStyleTexts.copyWith(
                                    color: hexToColor("#0065A0"), fontSize: 15.0),
                                maxLines: 1,
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color(0x50ADDBC0),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: hexToColor("#0065A0"))),
                                  fillColor:
                                  const Color.fromARGB(80, 173, 205, 219),
                                  filled: true,
                                  hintText: AppStrings.userEmailHintText,
                                  hintStyle: kGoogleStyleTexts
                                      .copyWith(
                                      color: hexToColor("#5F93B1"),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppStrings.userPassword,
                                  style:
                                  kGoogleStyleTexts.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: maxLines * 25.0,
                            child: TextFormField(
                                textInputAction: TextInputAction.done,
                                textAlign: TextAlign.justify,
                                controller: passwordController,
                                onSaved: (val) => _password = val!,
                                keyboardType: TextInputType.text,
                                style: kGoogleStyleTexts.copyWith(
                                    color: hexToColor("#0065A0"), fontSize: 15.0),
                                maxLines: 1,
                                obscureText: !_showPassword,
                                decoration: InputDecoration(
                                  contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color(0x50ADDBC0),
                                      width: 1.0,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                          color: hexToColor("#0065A0"))),
                                  fillColor:
                                  const Color.fromARGB(80, 173, 205, 219),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _toggleVisibility();
                                    },
                                    child: Icon(
                                      _showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: hexToColor("#0065A0"),
                                      size: 22,
                                    ),
                                  ),
                                  filled: true,
                                  hintText: AppStrings.userPasswordHintText,
                                  hintStyle: kGoogleStyleTexts
                                      .copyWith(
                                      color: hexToColor("#5F93B1"),
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                )),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: hexToColor("#0065A0"),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onPressed: () => {},
                      child: Text(
                        AppStrings.loginButtonText,
                        style: kGoogleStyleTexts
                            .copyWith(color: Colors.white, fontSize: 18.0),
                      )),
                )
              ],
            ),
          ),
        )

      ),
    )
    );
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }



  TextStyle kGoogleStyleTexts = GoogleFonts.nunito(
      fontWeight: FontWeight.w600, color: Colors.black, fontSize: 20.0);

}

class AppStrings {
  static const String loginNowText = "SignIn";
  static const String userName = 'Username';
  static const String userPassword = 'Password';
  static const String loginButtonText = 'Login';
  static const String loginText = "Hey! Admin, please go ahead!";
  static const String userEmailHintText = "person0@email.com";
  static const String userPasswordHintText = "Must have at least 8 characters";
  static const String dashboardText = "Dashboard";
}