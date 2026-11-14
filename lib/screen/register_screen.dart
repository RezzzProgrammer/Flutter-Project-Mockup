import 'dart:convert';

import 'package:flutter/material.dart';

import '../services/api_services.dart';
import '../theme.dart';
import '../widgets/common.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool _obscure = true;
  bool _loading = false;
  String? _error;

  /// Error dari server per kolom (mis. "Email sudah terdaftar.").
  final Map<String, String> _serverErrors = {};

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  // ---- validasi sisi klien (aturannya sama dengan di backend) ----

  String? _validateUsername(String? v) {
    final s = (v ?? '').trim();
    if (!RegExp(r'^[A-Za-z0-9_.]{3,30}$').hasMatch(s)) {
      return 'Username 3-30 karakter: huruf, angka, titik, atau underscore.';
    }
    return _serverErrors['username'];
  }

  String? _validateEmail(String? v) {
    final s = (v ?? '').trim();
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(s)) {
      return 'Format email tidak valid.';
    }
    return _serverErrors['email'];
  }

  String? _validatePassword(String? v) {
    final s = v ?? '';
    if (s.length < 8) return 'Password minimal 8 karakter.';
    if (utf8.encode(s).length > 72) return 'Password maksimal 72 karakter.';
    return _serverErrors['password'];
  }

  String? _validateConfirm(String? v) =>
      v == _password.text ? null : 'Konfirmasi password tidak sama.';

  void _clearServerError(String field) {
    if (_serverErrors.remove(field) != null) setState(() {});
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    _serverErrors.clear();
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final user = await ApiService.instance.register(
        username: _username.text.trim(),
        email: _email.text.trim(),
        password: _password.text,
      );
      if (!mounted) return;
      Navigator.pop(context, user.username); // kembali ke Login
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _serverErrors
          ..clear()
          ..addAll(e.fieldErrors);
        _error = e.fieldErrors.isEmpty ? e.message : null;
      });
      if (e.fieldErrors.isNotEmpty) _formKey.currentState!.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: _loading ? null : () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -1),
            radius: 0.9,
            colors: [AppColors.glow, AppColors.background],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 32),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buat akun',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Daftar untuk mulai mendengarkan musik.',
                    style: TextStyle(fontSize: 15, color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 28),
                  if (_error != null) ...[
                    ErrorBanner(_error!),
                    const SizedBox(height: 18),
                  ],
                  const FieldLabel('Username'),
                  TextFormField(
                    controller: _username,
                    enabled: !_loading,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    decoration: appInput(
                      hint: 'mis. budi_01',
                      prefix: const Icon(
                        Icons.alternate_email,
                        color: AppColors.textMuted,
                      ),
                    ),
                    onChanged: (_) => _clearServerError('username'),
                    validator: _validateUsername,
                  ),
                  const SizedBox(height: 18),
                  const FieldLabel('Email'),
                  TextFormField(
                    controller: _email,
                    enabled: !_loading,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autocorrect: false,
                    decoration: appInput(
                      hint: 'nama@email.com',
                      prefix: const Icon(
                        Icons.mail_outline,
                        color: AppColors.textMuted,
                      ),
                    ),
                    onChanged: (_) => _clearServerError('email'),
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 18),
                  const FieldLabel('Password'),
                  TextFormField(
                    controller: _password,
                    enabled: !_loading,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.next,
                    decoration: appInput(
                      hint: 'Minimal 8 karakter',
                      prefix: const Icon(
                        Icons.lock_outline,
                        color: AppColors.textMuted,
                      ),
                    ).copyWith(
                      suffixIcon: IconButton(
                        tooltip: _obscure
                            ? 'Tampilkan password'
                            : 'Sembunyikan password',
                        icon: Icon(
                          _obscure
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.textMuted,
                        ),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    onChanged: (_) => _clearServerError('password'),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 18),
                  const FieldLabel('Konfirmasi password'),
                  TextFormField(
                    controller: _confirm,
                    enabled: !_loading,
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    decoration: appInput(
                      hint: 'Ulangi password',
                      prefix: const Icon(
                        Icons.lock_outline,
                        color: AppColors.textMuted,
                      ),
                    ),
                    validator: _validateConfirm,
                  ),
                  const SizedBox(height: 28),
                  FilledButton(
                    style: AppButtons.primary,
                    onPressed: _loading ? null : _submit,
                    child: _loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Daftar'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah punya akun? ',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                        ),
                      ),
                      GestureDetector(
                        onTap: _loading ? null : () => Navigator.pop(context),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
