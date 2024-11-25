
import 'package:flutter/material.dart';
import 'package:potential/utils/styleConstants.dart';

import '../app_assets_constants/AppColors.dart';

class NormalTextFormField extends StatelessWidget {
  const NormalTextFormField({
    super.key,
    this.fieldValidator,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    required this.hintText,
    required this.mainController,
  });

  final TextEditingController mainController;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String hintText;
  final fieldValidator;
  final inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: mainController,
      onSaved: (val) => mainController.text = val!,
      style: kGoogleStyleTexts.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.blackTextColor,
        fontSize: 15.0,
      ),
      maxLines: 1,
      validator: fieldValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.redAccent,
            width: 1.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.formBorder,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.formBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.hintTextColor,
            width: 2.0,
          ),
        ),
        fillColor: const Color.fromARGB(30, 173, 205, 219),
        filled: true,
        hintText: hintText,
        hintStyle: kGoogleStyleTexts.copyWith(
            color: AppColors.hintTextColor,
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}

class ObscuredTextFormField extends StatelessWidget {
  const ObscuredTextFormField({
    super.key,
    this.fieldValidator,
    this.inputFormatters,
    this.showData,
    this.suffixWidget,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.visiblePassword,
    required this.hintText,
    required this.mainController,
  });

  final TextEditingController mainController;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final String hintText;
  final showData;
  final suffixWidget;
  final fieldValidator;
  final inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      controller: mainController,
      onSaved: (val) => mainController.text = val!,
      style: kGoogleStyleTexts.copyWith(
        fontWeight: FontWeight.w400,
        color: AppColors.blackTextColor,
        fontSize: 15.0,
      ),
      maxLines: 1,
      validator: fieldValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      obscureText: !showData,
      decoration: InputDecoration(
        suffixIcon: suffixWidget,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.redAccent,
            width: 1.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.formBorder,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.formBorder,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: AppColors.hintTextColor,
            width: 2.0,
          ),
        ),
        fillColor: const Color.fromARGB(30, 173, 205, 219),
        filled: true,
        hintText: hintText,
        hintStyle: kGoogleStyleTexts.copyWith(
            color: AppColors.hintTextColor,
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}