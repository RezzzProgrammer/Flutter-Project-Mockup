import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/app_user.dart';

/// Error dari server atau jaringan, dengan pesan yang siap ditampilkan ke user.
class ApiException implements Exception {
  ApiException(
    this.message, {
    this.statusCode,
    this.fieldErrors = const {},
  });

  final String message;
  final int? statusCode;

  /// Pesan error per kolom, mis. {'email': 'Email sudah terdaftar.'}
  final Map<String, String> fieldErrors;

  @override
  String toString() => message;
}

class AuthResult {
  const AuthResult({required this.token, required this.user});

  final String token;
  final AppUser user;
}

/// Semua komunikasi dengan backend PHP ada di sini.
class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  static const _timeout = Duration(seconds: 15);

  Future<AppUser> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final json = await _send('POST', '/register', body: {
      'username': username,
      'email': email,
      'password': password,
    });
    return AppUser.fromJson(json['data']['user'] as Map<String, dynamic>);
  }

  /// [identifier] boleh berisi email ATAU username.
  Future<AuthResult> login({
    required String identifier,
    required String password,
  }) async {
    final json = await _send('POST', '/login', body: {
      'identifier': identifier,
      'password': password,
    });
    final data = json['data'] as Map<String, dynamic>;
    return AuthResult(
      token: data['token'] as String,
      user: AppUser.fromJson(data['user'] as Map<String, dynamic>),
    );
  }

  /// Cek token masih berlaku sekaligus ambil data user terbaru.
  Future<AppUser> me(String token) async {
    final json = await _send('GET', '/me', token: token);
    return AppUser.fromJson(json['data']['user'] as Map<String, dynamic>);
  }

  Future<void> logout(String token) async {
    try {
      await _send('POST', '/logout', token: token);
    } on ApiException {
      // Gagal logout di server tidak boleh menghalangi logout di aplikasi.
    }
  }

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    String? token,
  }) async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}$path');
    final headers = <String, String>{
      'Accept': 'application/json',
      if (body != null) 'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final http.Response res;
    try {
      final request = method == 'GET'
          ? http.get(uri, headers: headers)
          : http.post(
              uri,
              headers: headers,
              body: body == null ? null : jsonEncode(body),
            );
      res = await request.timeout(_timeout);
    } on TimeoutException {
      throw ApiException(
        'Server tidak merespons. Periksa koneksi dan pastikan backend berjalan.',
      );
    } catch (_) {
      throw ApiException(
        'Tidak dapat terhubung ke server (${AppConfig.apiBaseUrl}). '
        'Pastikan backend sudah berjalan.',
      );
    }

    Map<String, dynamic> json;
    try {
      json = jsonDecode(utf8.decode(res.bodyBytes)) as Map<String, dynamic>;
    } catch (_) {
      throw ApiException(
        'Respons server tidak valid (kode ${res.statusCode}).',
        statusCode: res.statusCode,
      );
    }

    if (res.statusCode >= 200 && res.statusCode < 300 && json['success'] == true) {
      return json;
    }

    final rawErrors = json['errors'];
    final fieldErrors = <String, String>{
      if (rawErrors is Map)
        for (final e in rawErrors.entries) e.key.toString(): e.value.toString(),
    };
    throw ApiException(
      json['message']?.toString() ?? 'Terjadi kesalahan (kode ${res.statusCode}).',
      statusCode: res.statusCode,
      fieldErrors: fieldErrors,
    );
  }
}
