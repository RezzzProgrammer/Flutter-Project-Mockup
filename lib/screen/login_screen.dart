import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                        const SizedBox(height: 36),
                        const _FieldLabel('Username'),
                        TextField(
                          decoration: appInput(hint: 'Masukkan username'),
                        ),
                        const SizedBox(height: 18),
                        const _FieldLabel('Password'),
                        TextField(
                          obscureText: true,
                          decoration: appInput(hint: 'Masukkan password'),
                        ),
                        const SizedBox(height: 28),
                        FilledButton(
                          style: AppButtons.primary,
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, '/home'),
                          child: const Text('Masuk'),
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
                          onPressed: () {}, // TODO: Google Sign-In
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
                              onTap: () {}, // TODO: halaman daftar
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
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textMuted,
        ),
      ),
    );
  }
}
