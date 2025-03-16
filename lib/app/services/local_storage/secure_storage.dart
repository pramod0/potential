import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import './storage_service.dart';

class SecureStorageService extends StorageService {
  // Singleton instance
  static final SecureStorageService _instance = SecureStorageService._internal();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  @override
  Future<void> initializeStorage() async {
    log("Storage initialized.");
  }

  @override
  Future<void> clearStorage() async {
    try {
      await _storage.deleteAll();
      log("All storage cleared.");
    } catch (e) {
      log("Failed to clear storage: $e");
    }
  }

  @override
  Future<void> saveValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      log("Value saved for key: $key");
    } catch (e) {
      log("Failed to save value for key $key: $e");
    }
  }

  @override
  Future<String?> getValue(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      log("Failed to read value for key $key: $e");
      return null;
    }
  }

  @override
  Future<void> updateValue(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
      log("Value updated for key: $key");
    } catch (e) {
      log("Failed to update value for key $key: $e");
    }
  }

  @override
  Future<void> removeValue(String key) async {
    try {
      await _storage.delete(key: key);
      log("Value removed for key: $key");
    } catch (e) {
      log("Failed to remove value for key $key: $e");
    }
  }

  Future<void> logAll() async {
    try {
      Map<String, String> allValues = await _storage.readAll();
      log("Stored values: $allValues");
    } catch (e) {
      log("Failed to log all values: $e");
    }
  }
}
