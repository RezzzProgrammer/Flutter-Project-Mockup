import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../services/api_services.dart';
import '../services/session.dart';
import '../theme.dart';
import '../widgets/common.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();

  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await ApiService.instance.login(
        identifier: _identifier.text.trim(),
        password: _password.text,
      );
      await Session.save(result.token, result.user);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _loading = false;
      });
    }
  }

  Future<void> _openRegister() async {
    // Halaman Daftar mengembalikan username bila akun berhasil dibuat.
    final username = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (_) => const RegisterScreen()));
    if (username == null || !mounted) return;
    setState(() {
      _identifier.text = username;
      _password.clear();
      _error = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Akun berhasil dibuat. Silakan masuk.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -1),
            radius: 0.9,
            colors: [AppColors.glow, AppColors.background],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(28, 56, 28, 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BrandBadge(
                            icon: Icons.music_note_rounded,
                            size: 68,
                            radius: 22,
                          ),
                          const SizedBox(height: 28),
                          const Text(
                            'Soundify',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Dengarkan musik dengan kualitas tinggi',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 32),
                          if (_error != null) ...[
                            ErrorBanner(_error!),
                            const SizedBox(height: 18),
                          ],
                          const FieldLabel('Email atau username'),
                          TextFormField(
                            controller: _identifier,
                            enabled: !_loading,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            decoration: appInput(
                              hint: 'Masukkan email atau username',
                              prefix: const Icon(
                                Icons.person_outline,
                                color: AppColors.textMuted,
                              ),
                            ),
                            validator: (v) => (v ?? '').trim().isEmpty
                                ? 'Email atau username wajib diisi.'
                                : null,
                          ),
                          const SizedBox(height: 18),
                          const FieldLabel('Password'),
                          TextFormField(
                            controller: _password,
                            enabled: !_loading,
                            obscureText: _obscure,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _submit(),
                            decoration: appInput(
                              hint: 'Masukkan password',
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
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                              ),
                            ),
                            validator: (v) => (v ?? '').isEmpty
                                ? 'Password wajib diisi.'
                                : null,
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
                                : const Text('Masuk'),
                          ),
                          const SizedBox(height: 12),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.secondary,
                              side:
                                  const BorderSide(color: AppColors.secondary),
                              minimumSize: const Size.fromHeight(54),
                              shape: const StadiumBorder(),
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: _loading ? null : _openRegister,
                            child: const Text('Buat akun baru'),
                          ),
                          const SizedBox(height: 18),
                          const Row(
                            children: [
                              Expanded(child: Divider(color: AppColors.line)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'atau',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                              Expanded(child: Divider(color: AppColors.line)),
                            ],
                          ),
                          const SizedBox(height: 18),
                          FilledButton(
                            style: AppButtons.outlined,
                            onPressed:
                                _loading ? null : () {}, // TODO: Google Sign-In
                            child: const Text('Login dengan Google'),
                          ),
                          const Spacer(),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Belum punya akun? ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textMuted,
                                ),
                              ),
                              GestureDetector(
                                onTap: _loading ? null : _openRegister,
                                child: const Text(
                                  'Daftar',
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
            ),
          ),
        ),
      ),
    );
  }
}
