import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var textTheme = defaultTargetPlatform == TargetPlatform.android
    ? TextTheme(
        displayLarge: GoogleFonts.nunitoSans(
          fontSize: 57,
          color: Colors.black,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
          shadows: [
            const Shadow(
                blurRadius: 5.0, color: Colors.grey, offset: Offset(2, 2))
          ],
        ),
        displayMedium: GoogleFonts.nunitoSans(
          fontSize: 45,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.4,
        ),
        displaySmall: GoogleFonts.nunitoSans(
          fontSize: 36,
          color: Colors.black87,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
        headlineLarge: GoogleFonts.nunitoSans(
          fontSize: 32,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
        headlineMedium: GoogleFonts.nunitoSans(
          fontSize: 28,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
        ),
        headlineSmall: GoogleFonts.nunitoSans(
          fontSize: 24,
          color: Colors.blueAccent,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: GoogleFonts.nunitoSans(
          fontSize: 22,
          color: Colors.green,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        titleMedium: GoogleFonts.nunitoSans(
          fontSize: 16,
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: GoogleFonts.nunitoSans(
          fontSize: 14,
          color: Colors.green,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: GoogleFonts.nunitoSans(
          fontSize: 16,
          color: Colors.grey[800],
          fontWeight: FontWeight.normal,
          letterSpacing: 0.1,
        ),
        bodyMedium: GoogleFonts.nunitoSans(
          fontSize: 14,
          color: Colors.grey[700],
          fontWeight: FontWeight.normal,
          letterSpacing: 0.1,
        ),
        bodySmall: GoogleFonts.nunitoSans(
          fontSize: 12,
          color: Colors.grey[600],
          fontWeight: FontWeight.normal,
          letterSpacing: 0.1,
        ),
        labelLarge: GoogleFonts.nunitoSans(
          fontSize: 14,
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
        labelMedium: GoogleFonts.nunitoSans(
          fontSize: 12,
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: GoogleFonts.nunitoSans(
          fontSize: 11,
          color: Colors.deepPurple,
          fontWeight: FontWeight.bold,
        ),
      )
    : CupertinoTextThemeData(
        primaryColor: CupertinoColors.systemBlue,
        textStyle: GoogleFonts.nunitoSans(
          fontSize: 17,
          color: CupertinoColors.black,
        ),
        actionTextStyle: GoogleFonts.nunitoSans(
          fontSize: 17,
          color: CupertinoColors.activeBlue,
        ),
        tabLabelTextStyle: GoogleFonts.nunitoSans(
          fontSize: 10,
          color: CupertinoColors.inactiveGray,
        ),
        navTitleTextStyle: GoogleFonts.nunitoSans(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: CupertinoColors.black,
        ),
        navLargeTitleTextStyle: GoogleFonts.nunitoSans(
          fontSize: 34,
          fontWeight: FontWeight.w700,
          color: CupertinoColors.black,
        ),
        navActionTextStyle: GoogleFonts.nunitoSans(
          fontSize: 17,
          color: CupertinoColors.activeBlue,
        ),
        pickerTextStyle: GoogleFonts.nunitoSans(
          fontSize: 22,
          color: CupertinoColors.black,
        ),
        dateTimePickerTextStyle: GoogleFonts.nunitoSans(
          fontSize: 20,
          color: CupertinoColors.black,
        ),
      );
