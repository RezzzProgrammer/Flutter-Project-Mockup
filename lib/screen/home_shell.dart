import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';
import 'home_screen.dart';
import 'library_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

/// Kerangka utama: 4 tab + bilah navigasi bawah (+ pemutar mini).
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const _pages = <Widget>[
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Pemutar mini tampil di Beranda dan Koleksi, sesuai mockup.
    final showMini = _index == 0 || _index == 2;

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _index, children: _pages)),
      bottomNavigationBar: Container(
        color: AppColors.background,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showMini)
              MiniPlayer(onTap: () => Navigator.pushNamed(context, '/player')),
            const Divider(height: 1, color: AppColors.line),
            BottomNavigationBar(
              currentIndex: _index,
              onTap: (i) => setState(() => _index = i),
              type: BottomNavigationBarType.fixed,
              backgroundColor: AppColors.background,
              elevation: 0,
              selectedItemColor: AppColors.secondary,
              unselectedItemColor: AppColors.textMuted,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'Beranda',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Cari',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_music_outlined),
                  activeIcon: Icon(Icons.library_music),
                  label: 'Koleksi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: 'Profil',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
