import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _quick = [
    'Lagu Favorit',
    'Playlist 1',
    'Playlist 2',
    'Playlist 3',
    'Playlist 4',
    'Playlist 5',
  ];

  void _openPlayer(BuildContext context) =>
      Navigator.pushNamed(context, '/player');

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      children: [
        const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo,',
                    style: TextStyle(fontSize: 13, color: AppColors.textMuted),
                  ),
                  Text(
                    'Selamat siang',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            BrandBadge(icon: Icons.person, size: 42),
          ],
        ),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _quick.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 52,
          ),
          itemBuilder: (context, i) => _QuickCard(
            label: _quick[i],
            index: i,
            onTap: () => _openPlayer(context),
          ),
        ),
        const SectionTitle('Terakhir diputar'),
        for (var i = 1; i <= 3; i++)
          SongTile(
            title: 'Judul Lagu $i',
            subtitle: 'Nama Artis',
            coverIndex: i,
            coverSize: 48,
            onTap: () => _openPlayer(context),
          ),
        const SectionTitle('Rekomendasi', top: 18),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) => GestureDetector(
              onTap: () => _openPlayer(context),
              child: SizedBox(
                width: 104,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CoverArt(size: 104, index: i + 2, radius: 16),
                    const SizedBox(height: 8),
                    const Text(
                      'Judul Lagu',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Nama Artis',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickCard extends StatelessWidget {
  const _QuickCard({
    required this.label,
    required this.index,
    required this.onTap,
  });

  final String label;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CoverArt(size: 52, index: index, radius: 0),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
