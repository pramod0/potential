import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

// import 'package:ivcargo/constants/app_strings.dart';
import '../../../utils/constants/strings.dart';
import 'native_status_service.dart';

class NetworkStatusService extends NativeStatusService {
  static final NetworkStatusService _instance = NetworkStatusService._internal();
  final Connectivity _connectivity = Connectivity();

  // StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isConnected = false;

  NetworkStatusService._internal();

  factory NetworkStatusService() => _instance;

  @override
  Future<bool> isServiceEnabled() async {
    List list = await _connectivity.checkConnectivity();
    if (list.contains(ConnectivityResult.none)) {
      _isConnected = false;
    } else {
      _isConnected = true;
    }
    return _isConnected;
  }

  @override
  Future<String> requestToEnableService() async {
    return AppStrings.noInternetConnDescriptionThree;
  }

  @override
  void handleError(Exception e) {
    log("Network error: $e");
  }

  @override
  void addStatusChangeListener(Function(bool isEnabled) listener) {
    log("Not added");
  }

  @override
  void removeStatusChangeListener() {
    // _subscription?.cancel();
  }

  @override
  Future<bool> hasPermissions() async {
    return true; // No permissions required for connectivity checks.
  }

  @override
  String getServiceStateDetails() {
    return _isConnected ? "Connected to the network" : AppStrings.noInternetConnTitle;
  }
}
