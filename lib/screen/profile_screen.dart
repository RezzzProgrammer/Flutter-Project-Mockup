import 'package:flutter/material.dart';

import '../services/api_services.dart';
import '../services/session.dart';
import '../theme.dart';
import '../widgets/common.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final navigator = Navigator.of(context);
    final token = Session.token;
    if (token != null) await ApiService.instance.logout(token);
    await Session.clear();
    navigator.pushNamedAndRemoveUntil('/login', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final user = Session.user;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            tooltip: 'Pengaturan',
            icon: const Icon(Icons.settings_outlined),
            color: AppColors.textMuted,
            onPressed: () {},
          ),
        ),
        Center(
          child: Container(
            width: 96,
            height: 96,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.brandGradient,
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
              ),
              child: const Icon(
                Icons.person,
                size: 44,
                color: AppColors.secondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: Text(
            user?.username ?? 'Pengguna',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
        ),
        if (user != null)
          Center(
            child: Text(
              user.email,
              style: const TextStyle(fontSize: 14, color: AppColors.textMuted),
            ),
          ),
        const SizedBox(height: 12),
        Center(
          child: OutlinedButton(
            style: AppButtons.small,
            onPressed: () {}, // TODO: edit profil
            child: const Text('Edit profil'),
          ),
        ),
        const SectionTitle('Koleksi', top: 26),
        for (var i = 1; i <= 3; i++)
          SongTile(
            title: 'Playlist $i',
            subtitle: 'Playlist Anda',
            coverIndex: i,
            showMore: false,
            onTap: () {},
          ),
        const SizedBox(height: 8),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.surface,
            foregroundColor: AppColors.secondary,
            minimumSize: const Size.fromHeight(44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          onPressed: () {},
          child: const Text('Lihat semua koleksi'),
        ),
        const SectionTitle('Artis yang baru diputar'),
        SizedBox(
          height: 104,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, i) => SizedBox(
              width: 72,
              child: Column(
                children: [
                  CoverArt(size: 72, index: i + 1, circle: true),
                  const SizedBox(height: 8),
                  Text(
                    'Artis ${i + 1}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        OutlinedButton.icon(
          style: AppButtons.small.copyWith(
            minimumSize: const WidgetStatePropertyAll(Size.fromHeight(48)),
            foregroundColor: const WidgetStatePropertyAll(AppColors.error),
          ),
          onPressed: () => _logout(context),
          icon: const Icon(Icons.logout, size: 18),
          label: const Text('Keluar'),
        ),
      ],
    );
  }
}
