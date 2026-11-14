import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/app_user.dart';

/// Menyimpan token + data user di perangkat agar tetap login saat app dibuka lagi.
/// (Untuk aplikasi produksi, simpan token di flutter_secure_storage.)
class Session {
  Session._();

  static const _tokenKey = 'auth_token';
  static const _userKey = 'auth_user';

  static String? token;
  static AppUser? user;

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(_tokenKey);
    final raw = prefs.getString(_userKey);
    try {
      user = raw == null
          ? null
          : AppUser.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      user = null;
    }
  }

  static Future<void> save(String newToken, AppUser newUser) async {
    token = newToken;
    user = newUser;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, newToken);
    await prefs.setString(_userKey, jsonEncode(newUser.toJson()));
  }

  static Future<void> clear() async {
    token = null;
    user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}
