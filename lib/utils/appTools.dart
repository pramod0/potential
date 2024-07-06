import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

String formattedDate(date) {
  return DateFormat('dd/MM/yyyy').format(DateTime.parse(date));
}
