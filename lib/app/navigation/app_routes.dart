class AppRoutes {
  // Authentication Routes
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgotPassword';
  static const verifyOTPAndNewPass = '/verifyOTPAndNewPass';

  // Dashboard and Portfolio Routes
  static const home = '/';
  static const dashboard = '/dashboard';
  static const schemeDetails = '/schemeDetails';
  static const sipCalc = '/sipCalculator';

  // Graphs and Analysis Routes
  static const graphScheme = '/schemeAnalysis';
  static const graphPortFolio = '/portfolioAnalysis';
  static const graphInvestmentAnalysis = '/investmentAnalysis';

  // Settings Routes
  static const settings = '/settings';
  static const biometricSetting = '/biometricSetting';

  // Profile Routes
  static const profile = '/profile';

  // Consent Routes
  static const checkedNoCan = '/checkedNoCan';
  static const checkedNoConsent = '/checkedNoConsent';
  static const consentNoData = '/consentNoData';

  // Splash and Misc Routes
  static const splash = '/splash';
}
