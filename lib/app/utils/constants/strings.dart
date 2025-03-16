class AppStrings {
  // Actions and Buttons
  static const String loginNow = "Hey,\nLet's begin Investing."; // Login welcome message
  static const String doNotHaveAc = "Don't have an account?"; // Login welcome message
  static const String alreadyHaveAc = "Already have an account?"; // Login welcome message
  static const String signUpWithEmail = "Sign up with Email"; // Button text for signup
  static const String noRegistrationFound =
      "We kindly request that you reach out to our support team,\nas it appears you are not currently registered as a user with the firm.\nYour co-operation is greatly appreciated.\n\nThank You!!!";
  static const String generateOTP = "Generate OTP"; // Button text for generating OTP
  static const String verifyLater = 'Verify Later'; // Verify Later Button label
  static const String login = 'Login'; // Login Button Label
  static const String logout = 'Logout'; // Logout Button Label
  static const String signUp = 'Sign Up'; // Sign Up Button label
  static const String signIn = 'Sign In'; // Sign In Button label

  // Labels
  static const String userName = 'Username'; // Field label
  static const String email = 'Email'; // General email field label
  static const String emailHint = 'Your Email Address'; // General email field label
  static const String password = 'Password'; // General password field label
  static const String passwordHint = '1234@Xyz'; // General password field label
  static const String confirmPassword = 'Confirm Password'; // Confirm password label
  static const String mobileNumber = 'Mobile Number'; // Mobile number field label
  static const String mobileNumberHint = mobileNumber; // Mobile number field label
  static const String panCard = 'PAN Card Number'; // PAN card field label
  static const String confirmPANCard = 'Confirm PAN Card Number'; // PAN card field label
  static const String panCardHint = 'AAAAA1234A'; // PAN card field label
  static const String verificationCode = 'Verification Code'; // Verification Code label
  static const String firstName = 'First Name'; // First Name field Example
  static const String firstNameHint = firstName; // Firstname Example
  static const String middleName = 'Middle Name'; // First Name field Example
  static const String middleNameHint = middleName; // Firstname Example
  static const String lastName = 'Last Name'; // Last Name field Label
  static const String lastNameHint = lastName; // Surname Example

  // Validation Messages
  static const String required = "required";
  static const String emailRequired = "$email is $required"; // Email validation
  static const String validEmailError = "Please enter a valid $email ID"; // Invalid email
  static const String passwordRequired = "$password is $required"; // Password validation
  static const String passwordLength8Error = "$password must be at least 8 characters long"; // Length error
  static const String passwordLength16Error = "$password must be at the most 16 characters long"; // Length error
  static const String confirmPasswordMismatch = "Both ${password}s should be the same"; // Mismatch Password error
  static const String confirmPANMismatch = "Both PAN Numbers should be same"; // Mismatch PAN Number error
  static const String invalidMobile = "Please enter a valid $mobileNumber"; // Mobile validation
  static const String panCardRequired = "$panCard is $required"; // PAN card validation
  static const String invalidPAN = "Invalid $panCard"; // PAN card validation
  static const String contactNoRequired = "Contact Number is $required"; // Contact Number validation
  static const String firstNameRequired = "$firstName is $required"; // Contact Number validation
  static const String middleNameRequired = "$middleName is $required"; // Contact Number validation
  static const String lastNameRequired = "$lastName is $required"; // Contact Number validation
  static const String dobRequired = "Date of Birth is $required"; // Contact Number validation
  static const String mobileNumberRequired = "$mobileNumber is $required"; // Contact Number validation

  // Greetings
  static const String goodMorning = "Good Morning,"; // Morning greeting
  static const String goodAfternoon = "Good Afternoon,"; // Afternoon greeting
  static const String goodEvening = "Good Evening,"; // Evening greeting

  // No Internet Messages
  static const String noInternetTitle = "No Internet Connection"; // Dialog title
  static const String noInternetDescription =
      "You are not connected to the internet.\nMake sure Wi-Fi is on, Airplane mode is off, and try again."; // Dialog body
  static const String retry = "Retry"; // Retry button

  // Dashboard Text
  static const String dashboard = "Dashboard"; // Dashboard title
  static const String exploreCategories = "Explore Categories"; // Explore button text

  // Investment Related
  static const String totalInvestments = "Total Investments"; // Total investment field
  static const String returns = "Returns"; // Returns field
  static const String invested = "Invested"; // Invested field
  static const String rupeeSymbol = '\u{20B9}'; // Indian rupee symbol
  static const String total = "Total";
  static const String current = 'Current Value';
  static const String investments = 'Investments';
  static const String reports = 'Analyze Report';

  // Exit Dialog
  static const String exitTitle = "Are you sure?"; // Exit dialog title
  static const String exitDescription = "Do you want to exit the app?"; // Exit dialog message
  static const String cancel = "Cancel"; // Cancel button
  static const String exit = "Exit"; // Exit button

  static const String myAppName = "IVCargo";

  static const String unAvailableData = "Unable Fetch Data.";
  static const String serverUnreachable = "Unable to reach server at the moment.";

  //permissions for
  static const String network = "Internet";
  static const String bluetooth = "Bluetooth";
  static const String storage = "Storage";
  static const String bioMetric = "Bio-Metric";
  static const String location = "Location";
  static const String notification = "Notification";
  static const String message = "Read Messages";

  //is/isn't permitted
  static const String permissionIsGranted = "permission is Granted.";
  static const String permissionIsNotGranted = "permission is not Granted.";

  //is/isn't available
  static const String isAvailable = "is available.";
  static const String isNotAvailable = "is not available.";

  //permission specific strings
  static const String networkPermissionGranted = "$network $permissionIsGranted.";
  static const String networkPermissionNotGranted = "$network $permissionIsNotGranted.";
  static const String btPermissionGranted = "$bluetooth $permissionIsGranted.";
  static const String btPermissionNotGranted = "$bluetooth $permissionIsNotGranted.";
  static const String storagePermissionGranted = "$storage $permissionIsGranted.";
  static const String storagePermissionNotGranted = "$storage $permissionIsNotGranted.";
  static const String bioMetricPermissionGranted = "$bioMetric $permissionIsGranted.";
  static const String bioMetricPermissionNotGranted = "$bioMetric $permissionIsNotGranted.";
  static const String locationPermissionGranted = "$bioMetric $permissionIsGranted.";
  static const String locationPermissionNotGranted = "$bioMetric $permissionIsNotGranted.";
  static const String notificationPermissionGranted = "$bioMetric $permissionIsGranted.";
  static const String notificationPermissionNotGranted = "$bioMetric $permissionIsNotGranted.";
  static const String messagesPermissionGranted = "$message $permissionIsGranted.";
  static const String messagesPermissionNotGranted = "$message $permissionIsNotGranted.";

  // theme related strings
  static const String switched = "Switched";
  static const String darkTheme = "Dark Theme";
  static const String lightTheme = "Light Theme";
  static const String switchedToDarkTheme = "$switched to $darkTheme";
  static const String switchedToLightTheme = "$switched to $lightTheme";
  static const String switchToDarkTheme = "Switch to $darkTheme";
  static const String switchToLightTheme = "Switch to $lightTheme";

  // AUTHENTICATION TEXTS
  static const String noLocalAuth = "Security Service $isNotAvailable";
  static const String pin = "Pin";
  static const String mPin = "mPin";
  static const String fingerPrint = "Finger Print";
  static const String faceLock = "Face Lock";

  //ENABLE TEXTS
  static const String enabled = "Enabled";
  static const String disabled = "Disabled";
  static const String enable = "Enable";
  static const String disable = "Disable";

  //PERMISSION ENABLE/DISABLE TEXTS
  static const String enableFingerPrint = "$enable $fingerPrint";
  static const String disableFingerPrint = "$disable $fingerPrint";
  static const String fingerPrintAvailable = "$fingerPrint $isAvailable";
  static const String fingerPrintIsNotAvailable = "$fingerPrint $isNotAvailable";
  static const String enableFaceLock = "$enable $faceLock";
  static const String disableFaceLock = "$disable $fingerPrint";
  static const String faceLockAvailable = "$faceLock $isAvailable";
  static const String faceLockIsNotAvailable = "$faceLock $isNotAvailable";
  static const String fingerPrintEnabled = "$fingerPrint $enabled";
  static const String fingerPrintDisabled = "$fingerPrint $disabled";
  static const String faceLockEnabled = "$faceLock $enabled";
  static const String faceLockDisabled = "$fingerPrint $disabled";
  static const String enableBioMetric = "$enable $bioMetric";
  static const String disableBioMetric = "$disable $bioMetric";
  static const String bioMetricAvailable = "$bioMetric $isAvailable";
  static const String bioMetricIsNotAvailable = "$bioMetric $isNotAvailable";

  // OPERATIONAL TEXTS
  static const String dismiss = "Dismiss";
  static const String quoteOfTheDay = "Quote of the day";
  static const String exploreCat = "Explore Categories";
  static const String assignment = "Assignments";
  static const String attendance = "Attendance";
  static const String performance = "Performance";
  static const String schedule = "Schedule";
  static const String complete = "COMPLETE";
  static const String pending = "PENDING";
  static const String overdue = "OVERDUE";
  static const String partialComplete = "PARTIAL";
  static const String assign = "Assignment";
  static const String attachment = "Attachments";
  static const String readMore = "read more...";
  static const String readLess = "read less...";
  static const String description = "Description";
  static const String assignBy = "Assigned By";
  static const String lastSubmissionDate = "Last Submission Date";

  // LOGIN SCREEN WELCOME MSG TEXT
  static const String hello = "Hello,";
  static const String welcomeBack = "Welcome Back";

  // EXIT DIALOG TEXTS
  static const String dialogTitleAssure = "Are you sure?";
  static const String dialogDescriptionAssure = "Do you want to exit the app";

  // PREV & NEXT BUTTON TEXTS
  static const String prevStep = "Prev";
  static const String nextStep = "Next";
  static const String saveDetails = "Save";

  // No INTERNET TEXT
  static const String noInternetConnTitle = "No Internet Connection";
  static const String noInternetConnDescriptionOne = "You are not connected to the internet.";
  static const String noInternetConnDescriptionTwo = "Make sure Wi-Fi is on, Airplane mode is off and try again";
  static const String noInternetConnDescriptionThree =
      "Cannot enable network programmatically. Please check your network settings.";

  static const String rupeeSign = '\u{20B9}';
}
