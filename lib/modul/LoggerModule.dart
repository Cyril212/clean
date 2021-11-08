import 'package:flutter/foundation.dart';

class Logger {

  static const _FORCE_ENABLE_LOGGING = false;
  static const DEFAULT_TAG = 'UNKNOWN_TAG';

  static void d(String message, {String tag = DEFAULT_TAG}) {
    if (_FORCE_ENABLE_LOGGING || !kReleaseMode) {
      debugPrint('$tag: $message');
    }
  }

  static void e(String message, {String tag = DEFAULT_TAG}) {
    if (_FORCE_ENABLE_LOGGING || !kReleaseMode) {
      debugPrint('$tag: $message');
    }
  }
}