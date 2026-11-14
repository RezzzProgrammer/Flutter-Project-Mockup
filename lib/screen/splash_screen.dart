import 'package:flutter/material.dart';

import '../services/api_services.dart';
import '../services/session.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Layar pertama: cek apakah user masih login, lalu arahkan ke Beranda / Login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _decideRoute();
  }

  Future<void> _decideRoute() async {
    await Session.load();
    var route = '/login';

    final token = Session.token;
    if (token != null) {
      try {
        final user = await ApiService.instance.me(token);
        await Session.save(token, user);
        route = '/home';
      } on ApiException catch (e) {
        if (e.statusCode == 401) {
          await Session.clear(); // token kedaluwarsa / sudah dicabut
        } else if (Session.user != null) {
          route = '/home'; // server tidak terjangkau: pakai data yang tersimpan
        } else {
          await Session.clear();
        }
      }
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BrandBadge(icon: Icons.music_note_rounded, size: 68, radius: 22),
            SizedBox(height: 24),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
