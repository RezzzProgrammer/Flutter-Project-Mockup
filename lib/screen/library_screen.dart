import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  static const _filters = ['Playlist', 'Favorit', 'Artis', 'Album'];
  static const _lists = [
    ('Lagu Favorit', 'Daftar otomatis'),
    ('Santai Sore', 'Playlist Anda'),
    ('Fokus Belajar', 'Playlist Anda'),
    ('Perjalanan', 'Playlist Anda'),
    ('Olahraga', 'Playlist Anda'),
    ('Malam Hari', 'Playlist Anda'),
  ];

  int _filter = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Koleksi',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),
            IconButton.filled(
              tooltip: 'Buat playlist',
              style: IconButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.secondary,
              ),
              icon: const Icon(Icons.add),
              onPressed: () {}, // TODO: buat playlist
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          children: [
            for (var i = 0; i < _filters.length; i++)
              AppChip(
                label: _filters[i],
                selected: i == _filter,
                onTap: () => setState(() => _filter = i),
              ),
          ],
        ),
        const SizedBox(height: 14),
        for (var i = 0; i < _lists.length; i++)
          SongTile(
            title: _lists[i].$1,
            subtitle: _lists[i].$2,
            coverIndex: i,
            coverSize: 56,
            onTap: () {},
          ),
      ],
    );
  }
}
