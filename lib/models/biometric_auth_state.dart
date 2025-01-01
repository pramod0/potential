import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

class BiometricDetails with ChangeNotifier {
  static final BiometricDetails _instance = BiometricDetails._internal();
  final _storage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();

  bool _isBiometricOn = false;
  bool _isFaceOn = false;
  bool _isFingerPrintOn = false;
  bool _isUserConsentToBioMetric = false;

  BiometricDetails._internal();

  factory BiometricDetails() => _instance;

  // Getters
  bool get biometricOn => _isBiometricOn;

  bool get faceOn => _isFaceOn;

  bool get fingerPrintOn => _isFingerPrintOn;

  bool get userConsentToBioMetric => _isUserConsentToBioMetric;

  _printAll() {
    // print("_isBiometricOn $_isBiometricOn");
    // print("_isFaceOn $_isFaceOn");
    // print("_isFingerPrintOn $_isFingerPrintOn");
    // print("_isUserConsentToBioMetric $_isUserConsentToBioMetric");
  }

  // Method to load settings
  Future<void> loadSettings() async {
    _isBiometricOn = await _storage.read(key: 'isBiometricOn') == 'true';
    _isFaceOn = await _storage.read(key: 'isFaceOn') == 'true';
    _isFingerPrintOn = await _storage.read(key: 'isFingerPrintOn') == 'true';
    _isUserConsentToBioMetric =
        await _storage.read(key: 'isUserConsentToBioMetric') == 'true';

    _printAll();
    // Check system biometric and app lock compatibility
    await _checkSystemBiometricsCompatibility();
  }

  // Method to save settings
  Future<void> saveSettings({
    required bool isBiometricOn,
    required bool isFaceOn,
    required bool isFingerPrintOn,
    required bool isUserConsentToBioMetric,
  }) async {
    await _storage.write(key: 'isBiometricOn', value: isBiometricOn.toString());
    await _storage.write(key: 'isFaceOn', value: isFaceOn.toString());
    await _storage.write(
        key: 'isFingerPrintOn', value: isFingerPrintOn.toString());
    await _storage.write(
        key: 'isUserConsentToBioMetric',
        value: isUserConsentToBioMetric.toString());

    _isBiometricOn = isBiometricOn;
    _isFaceOn = isFaceOn;
    _isFingerPrintOn = isFingerPrintOn;
    _isUserConsentToBioMetric = isUserConsentToBioMetric;
  }

  // Check if the system supports biometrics and app lock
  Future<void> _checkSystemBiometricsCompatibility() async {
    try {
      // Check if the device supports biometrics
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      bool isDeviceSupported = await _localAuth.isDeviceSupported();

      // You can add additional checks here if your platform supports app locks
      // Example: Check if app-level system lock is active (if possible)

      if (canCheckBiometrics && isDeviceSupported) {
        _isBiometricOn = true;
        await _storage.write(key: 'isBiometricOn', value: 'true');
      }
      _printAll();
    } catch (e) {
      // print('Error checking system biometrics compatibility: $e');
    }
  }
}

// Riverpod Provider for BiometricDetails
final biometricProvider =
    Provider<BiometricDetails>((ref) => BiometricDetails());
