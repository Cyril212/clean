import 'dart:convert' as JSON;

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'LoggerModule.dart';

class SecurePreferencesModule {
  static const String TAG = 'SecurePreferencesModule';
  static const String _PREF_EMAIL = 'pref_email';
  static const String _PREF_PASSWORD = 'pref_password';
  static const String _PREF_USER_ID = 'pref_uder_id';


  late FlutterSecureStorage _storage;

  /// Init SecurePreferencesModule
  SecurePreferencesModule(){
    _storage = FlutterSecureStorage();
  }

  /// Get email of current user
  Future<String?> getEmail() {
    try {
      return _storage.read(key: _PREF_EMAIL);
    } catch (e) {
      Logger.e(e.toString(), tag: TAG);
      return Future.value(null);
    }
  }
  /// Put email of current user
  Future putEmail(String email) => _storage.write(key: _PREF_EMAIL, value: email);

  /// Get password of current user
  Future<String?> getPassword() {
    try {
      return _storage.read(key: _PREF_PASSWORD);
    } catch (e) {
      Logger.e(e.toString(), tag: TAG);
      return Future.value(null);
    }
  }

  /// Put password of current user
  Future putPassword(String password) => _storage.write(key: _PREF_PASSWORD, value: password);

  /// Clear email and password of current user
  Future clearUserData() async {
    await _storage.delete(key: _PREF_EMAIL);
    await _storage.delete(key: _PREF_PASSWORD);
    await _storage.delete(key: _PREF_USER_ID);
    return;
  }

  /// Get user_id of current user
  Future<String?> getUserId() {
    try {
      return _storage.read(key: _PREF_USER_ID);
    } catch (e) {
      Logger.e(e.toString(), tag: TAG);
      return Future.value(null);
    }
  }

  /// Put user_id of current user
  Future putUserId(int userId) => _storage.write(key: _PREF_USER_ID, value: userId.toString());

  /// Function to put bool as string
  Future putBool(String key, bool value) {
    if (value == true) {
      return _storage.write(key: key, value: 'true');
    } else {
      return _storage.write(key: key, value: 'false');
    }
  }
  /// Function to serialize and get bool from storage
  Future<bool> getBool(String key, bool defaultValue) async {
    final boolValue = await _storage.read(key: key);
    if (boolValue == 'true') {
      return true;
    } else if (boolValue == 'false') {
      return false;
    } else {
      return defaultValue;
    }
  }
}