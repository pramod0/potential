import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

class AuthService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> authenticateWithBiometrics() async {
    bool isAuthenticated = false;
    try {
      print("started");
      isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
            // useErrorDialogs: true,
            // stickyAuth: true,
            biometricOnly: true),
      );
      print("ended");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return isAuthenticated;
  }
}
