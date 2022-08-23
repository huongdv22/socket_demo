import 'dart:developer';

import 'package:flutter/foundation.dart';

class SystemUtils {
  static debugLog(String source, String message) {
    if (kDebugMode) log(message, name: source);
  }
}
