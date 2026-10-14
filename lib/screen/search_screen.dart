import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class _Category {
  const _Category(this.label, this.colors, this.fg);

  final String label;
  final List<Color> colors;
  final Color fg;
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  static const _cats = [
    _Category('Pop', [Color(0xFF8A2BE2), Color(0xFF4B1E8F)], Colors.white),
    _Category('Rock', [Color(0xFF4B1E8F), Color(0xFF2A1650)], Colors.white),
    _Category('Jazz', [Color(0xFF6A2CB0), Color(0xFF3A1D6E)], Colors.white),
    _Category('Hip-Hop', [Color(0xFF8A2BE2), Color(0xFF5B1FA8)], Colors.white),
    _Category(
      'Santai',
      [Color(0xFFDA70D6), Color(0xFFB24BD6)],
      AppColors.background,
    ),
    _Category('Fokus', [Color(0xFF5B1FA8), Color(0xFF2A1650)], Colors.white),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      children: [
        const Text(
          'Cari',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: appInput(
            hint: 'Apa yang ingin kamu dengarkan?',
            prefix: const Icon(Icons.search, color: AppColors.textMuted),
            pill: true,
          ),
        ),
        const SectionTitle('Jelajahi'),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _cats.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            mainAxisExtent: 80,
          ),
          itemBuilder: (context, i) {
            final c = _cats[i];
            return Container(
              padding: const EdgeInsets.all(14),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: c.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                c.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: c.fg,
                ),
              ),
            );
          },
        ),
        const SectionTitle('Baru diputar'),
        for (var i = 1; i <= 3; i++)
          SongTile(
            title: 'Judul Lagu $i',
            subtitle: 'Nama Artis',
            coverIndex: i,
            coverSize: 48,
            onTap: () => Navigator.pushNamed(context, '/player'),
          ),
      ],
    );
  }
}
