import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Palet "Midnight Velvet". Ubah warna di SINI saja, seluruh app ikut berubah.
class AppColors {
  static const background = Color(0xFF0D0D0F); // Obsidian Black
  static const surface = Color(0xFF1A1A24); // Dark Slate (kartu)
  static const surfaceHigh = Color(0xFF262633); // track slider, dll.
  static const line = Color(0xFF2A2A38); // garis pemisah / border
  static const primary = Color(0xFF8A2BE2); // Electric Violet
  static const secondary = Color(0xFFDA70D6); // Neon Orchid
  static const text = Color(0xFFF1F1F1); // Off-White
  static const textMuted = Color(0xFF9999AA); // Muted Lavender
  static const glow = Color(0x478A2BE2); // violet transparan untuk cahaya latar

  static const brandGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradasi sampul placeholder (semua dalam keluarga ungu).
  static const coverGradients = <List<Color>>[
    [Color(0xFF8A2BE2), Color(0xFFDA70D6)],
    [Color(0xFF5B1FA8), Color(0xFF8A2BE2)],
    [Color(0xFFDA70D6), Color(0xFF6A2CB0)],
    [Color(0xFF2A1650), Color(0xFF8A2BE2)],
    [Color(0xFF8A2BE2), Color(0xFF3A1D6E)],
    [Color(0xFFB24BD6), Color(0xFF4B1E8F)],
  ];
}

/// Gaya tombol yang dipakai ulang di beberapa layar.
class AppButtons {
  static final primary = FilledButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    minimumSize: const Size.fromHeight(54),
    shape: const StadiumBorder(),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
  );

  static final outlined = FilledButton.styleFrom(
    backgroundColor: AppColors.surface,
    foregroundColor: AppColors.text,
    minimumSize: const Size.fromHeight(54),
    shape: const StadiumBorder(side: BorderSide(color: AppColors.line)),
    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
  );

  static final small = OutlinedButton.styleFrom(
    foregroundColor: AppColors.text,
    side: const BorderSide(color: AppColors.line),
    shape: const StadiumBorder(),
    minimumSize: const Size(0, 40),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
  );
}

ThemeData buildAppTheme() {
  final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);
  // Font Plus Jakarta Sans. Kalau tidak mau pakai google_fonts, ganti baris
  // ini dengan: final text = base.textTheme.apply(bodyColor: ..., displayColor: ...);
  final text = GoogleFonts.plusJakartaSansTextTheme(base.textTheme).apply(
    bodyColor: AppColors.text,
    displayColor: AppColors.text,
  );

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.secondary,
      onSecondary: AppColors.background,
      surface: AppColors.surface,
      onSurface: AppColors.text,
    ),
    textTheme: text,
    sliderTheme: const SliderThemeData(
      trackHeight: 5,
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.surfaceHigh,
      thumbColor: AppColors.text,
      disabledActiveTrackColor: AppColors.line,
      disabledInactiveTrackColor: AppColors.surfaceHigh,
      disabledThumbColor: AppColors.textMuted,
      overlayColor: AppColors.glow,
    ),
  );
}
