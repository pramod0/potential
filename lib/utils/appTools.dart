import 'package:intl/intl.dart';

// Color String code) {
//   return const Colorint.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
// }

String formattedDate(date) {
  return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
}

String formattedDateTypeDashToSlash(date) {
  return date
      .toString()
      .replaceAll('-', '/'); //.toString().replaceAll('-', '/')
}

const Pattern emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp emailRegex = RegExp(emailPattern.toString());

const Pattern panPattern = '[A-Z]{5}[0-9]{4}[A-Z]{1}';
RegExp panRegex = RegExp(panPattern.toString());

const Pattern mobilePattern = "[6-9][0-9]{9}";
RegExp mobileRegex = RegExp(mobilePattern.toString());
