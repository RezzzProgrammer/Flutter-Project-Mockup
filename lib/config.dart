import 'package:flutter/foundation.dart';

class AppConfig {
  static const _override = String.fromEnvironment('API_BASE_URL');

  static String get apiBaseUrl {
    if (_override.isNotEmpty) return _override;

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      return 'http://localhost:8080';
    }
    return 'http:/localhost:8080';
  }
}
