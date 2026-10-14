import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'screen/home_shell.dart';
import 'screen/login_screen.dart';
import 'screen/player_screen.dart';
import 'theme.dart';

void main() => runApp(const SoundifyApp());

class SoundifyApp extends StatelessWidget {
  const SoundifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundify',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginScreen(),
        '/home': (_) => const HomeShell(),
        '/player': (_) => const PlayerScreen(),
      },
      // Hanya di Chrome (web): tampilkan app di dalam bingkai seukuran ponsel.
      // Di HP / emulator, builder ini tidak berpengaruh.
      builder: (context, child) {
        if (!kIsWeb) return child!;
        final size = MediaQuery.sizeOf(context);
        if (size.width < 500) return child!;

        const frameWidth = 390.0;
        final frameHeight = (size.height - 32).clamp(560.0, 844.0).toDouble();
        const border = 6.0;

        return ColoredBox(
          color: const Color(0xFF050507),
          child: Center(
            child: Container(
              width: frameWidth,
              height: frameHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColors.line, width: border),
              ),
              clipBehavior: Clip.antiAlias,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  size: Size(
                    frameWidth - border * 2,
                    frameHeight - border * 2,
                  ),
                ),
                child: child!,
              ),
            ),
          ),
        );
      },
    );
  }
}
