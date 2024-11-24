// import 'package:potential/utils/appTools.dart';
//
// import '../app_assets_constants/app_strings.dart';
//
// class Validations {
//   late var data;
//
//   String? validatePreRegistrationGender() {
//     if (data['gender'] != null && data['gender'] == '') {
//       return "Gender is required";
//     }
//     return null;
//   }
//
//   String? validatePreRegistrationField() {
//     var firstName = data['first_name'];
//     var middleName = data['middle_name'];
//     var lastName = data['last_name'];
//     if (firstName != null && firstName == '') {
//       return AppStrings.firstNameRequired;
//     } else if (middleName != null && middleName == '') {
//       return AppStrings.middleNameRequired;
//     } else if (lastName != null && lastName == '') {
//       return AppStrings.lastNameRequired;
//     }
//     return null;
//   }
//
//   String? validateStepThreeDOB() {
//     if (data['date_of_birth'] != null && data['date_of_birth'] == '') {
//       return AppStrings.dobRequired;
//     }
//     return null;
//   }
//
//   String? validateStepFourContactInfo() {
//     Pattern pattern = "(0/91)?[6-9][0-9]{9}";
//     RegExp regex = RegExp(pattern.toString());
//     var email = data['email'];
//     var contactNo = data['contact_no'];
//
//     if (email != null && email == '') {
//       return AppStrings.emailRequired;
//     } else if (!email!.contains('@')) {
//       return AppStrings.validEmailError;
//     } else if (contactNo != null && contactNo == '') {
//       return AppStrings.contactNoRequired;
//     } else if (!regex.hasMatch(contactNo!)) {
//       return "Invalid Contact Number";
//     }
//     return null;
//   }
//
//   // String? validateStepSixBloodType() {
//   //   if (data['blood_group'] != null && data['blood_group'] == '') {
//   //     return AppStrings.bloodTypeRequired;
//   //   }
//   //   return null;
//   // }
//
//   String? accountValidation(String fname, String lname, String mobNum,
//       String email, String password, String cPassword, String panCard) {
//
//     if (email.isEmpty) {
//       return AppStrings.emailRequired;
//     }
//     if (fname.isEmpty) {
//       return AppStrings.firstNameRequired;
//     }
//     if (lname.isEmpty) {
//       return AppStrings.lastNameRequired;
//     }
//     if (mobNum.isEmpty) {
//       return AppStrings.mobileNumberRequired;
//     }
//     if (!emailRegex.hasMatch(email)) {
//       return AppStrings.validEmailError;
//     }
//     if (password.isEmpty) {
//       return AppStrings.passwordRequired;
//     }
//     if (password.length < 8) {
//       return AppStrings.passwordLength8Error;
//     }
//     if (password.length > 16) {
//       return AppStrings.passwordLength16Error;
//     }
//     if (cPassword.isEmpty) {
//       return AppStrings.passwordRequired;
//     }
//     if (cPassword.length < 8) {
//       return AppStrings.passwordLength8Error;
//     }
//     if (cPassword.length > 16) {
//       return AppStrings.passwordLength16Error;
//     }
//     if (password != cPassword) {
//       return AppStrings.confirmPasswordMismatch;
//     }
//     if (!panRegex.hasMatch(panCard)) {
//       return AppStrings.invalidPAN;
//     }
//     if (mobNum.length < 10 || mobNum.length > 10) {
//       return AppStrings.invalidMobile;
//     }
//     return null;
//   }
// }
