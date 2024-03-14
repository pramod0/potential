import '../app_assets_constants/app_strings.dart';

class Validations {
  late var data;

  String? validatePreRegistrationGender() {
    if (data['gender'] != null && data['gender'] == '') {
      return "Gender is required";
    }
    return null;
  }

  String? validatePreRegistrationField() {
    var firstName = data['first_name'];
    var middleName = data['middle_name'];
    var lastName = data['last_name'];
    if (firstName != null && firstName == '') {
      return AppStrings.firstNameRequired;
    } else if (middleName != null && middleName == '') {
      return AppStrings.middleNameRequired;
    } else if (lastName != null && lastName == '') {
      return AppStrings.lastNameRequired;
    }
    return null;
  }

  String? validateStepThreeDOB() {
    if (data['date_of_birth'] != null && data['date_of_birth'] == '') {
      return AppStrings.dobRequired;
    }
    return null;
  }

  String? validateStepFourContactInfo() {
    Pattern pattern = "(0/91)?[6-9][0-9]{9}";
    RegExp regex = RegExp(pattern.toString());
    var email = data['email'];
    var contactNo = data['contact_no'];

    if (email != null && email == '') {
      return AppStrings.emailRequired;
    } else if (!email!.contains('@')) {
      return AppStrings.enterValidEmail;
    } else if (contactNo != null && contactNo == '') {
      return AppStrings.contactNoRequired;
    } else if (!regex.hasMatch(contactNo!)) {
      return "Invalid Contact Number";
    }
    return null;
  }

  String? validateStepFiveUserAddress() {
    if (data['street_address'] != null && data['street_address'] == '') {
      return AppStrings.streetAddressRequired;
    } else if (data['city'] != null && data['city'] == '') {
      return AppStrings.cityIsRequired;
    } else if (data['state'] != null && data['state'] == '') {
      return AppStrings.stateIsRequired;
    }
    return null;
  }

  // String? validateStepSixBloodType() {
  //   if (data['blood_group'] != null && data['blood_group'] == '') {
  //     return AppStrings.bloodTypeRequired;
  //   }
  //   return null;
  // }

  String? validateStepEightTeamLead() {
    if (data['reference_name'] != null && data['reference_name'] == '') {
      return AppStrings.referenceNameRequired;
    }
    return null;
  }

  String? validateStepSevenCareerTypeStudent() {
    if (data['college_name'] != null && data['college_name'] == '') {
      return AppStrings.collegeNameRequired;
    } else if (data['course_name'] != null && data['course_name'] == '') {
      return AppStrings.courseRequired;
    }
    return null;
  }

  String? validateStepSevenCareerTyeProfessional() {
    if (data['company_name'] != null && data['company_name'] == '') {
      return AppStrings.companyNameRequired;
    } else if (data['designation'] != null && data['designation'] == '') {
      return AppStrings.designationIsRequired;
    }
    return null;
  }

  String? accountValidation(String fname, String lname, String mobNum,
      String email, String password, String cPassword, String panCard) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    Pattern pattern2 = '[A-Z]{5}[0-9]{4}[A-Z]{1}';
    RegExp regex = RegExp(pattern.toString());
    RegExp regex2 = RegExp(pattern2.toString());
    if (email.isEmpty) {
      return AppStrings.isEmailRequired;
    }
    if (fname.isEmpty) {
      return AppStrings.isFNameRequired;
    }
    if (lname.isEmpty) {
      return AppStrings.isLNameRequired;
    }
    if (mobNum.isEmpty) {
      return AppStrings.isMobNoRequired;
    }
    if (!regex.hasMatch(email)) {
      return AppStrings.emailErrorText;
    }
    if (password.isEmpty) {
      return AppStrings.isPasswordRequired;
    }
    if (password.length < 8) {
      return AppStrings.passwordLength8ErrorText;
    }
    if (password.length > 16) {
      return AppStrings.passwordLength16ErrorText;
    }
    if (cPassword.isEmpty) {
      return AppStrings.isPasswordRequired;
    }
    if (cPassword.length < 8) {
      return AppStrings.passwordLength8ErrorText;
    }
    if (cPassword.length > 16) {
      return AppStrings.passwordLength16ErrorText;
    }
    if (password != cPassword) {
      return AppStrings.samePass;
    }
    if (!regex2.hasMatch(panCard)) {
      return AppStrings.inValidPAN;
    }
    if (mobNum.length < 10 || mobNum.length > 10) {
      return AppStrings.mobNoErrorText;
    }
    return null;
  }
}
