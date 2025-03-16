import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:potential/app/utils/constants/colors.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.formBorder, width: 1.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.formBorder, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.hintTextColor, width: 2.0),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.redAccent, width: 1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.redAccent, width: 2.0),
  ),
  labelStyle: GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.blackTextColor,
  ),
  hintStyle: GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.hintTextColor,
  ),
  errorStyle: GoogleFonts.nunitoSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.redAccent,
  ),
  contentPadding: const EdgeInsets.symmetric(
    vertical: 8,
    horizontal: 8,
  ),
  prefixStyle: GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.blackTextColor,
  ),
  suffixStyle: GoogleFonts.nunitoSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.blackTextColor,
  ),
  floatingLabelBehavior: FloatingLabelBehavior.auto,
  floatingLabelStyle: GoogleFonts.nunitoSans(
    fontSize: 8,
    fontWeight: FontWeight.w400,
    color: AppColors.hintTextColor2,
  ),
  isDense: true,
);

/**
    The thickness of the glyphs used to draw the text.
    Fonts are typically weighted on a 9-point scale, which, for historical reasons, uses the names 100 to 900. In Flutter, these are named w100 to w900 and have the following conventional meanings:
    w100: Thin, the thinnest font weight.
    w200: Extra light.
    w300: Light.
    w400: Normal. The constant FontWeight. normal is an alias for this value.
    w500: Medium.
    w600: Semi-bold.
    w700: Bold. The constant FontWeight. bold is an alias for this value.
    w800: Extra-bold.
    w900: Black, the thickest font weight.
 **/
