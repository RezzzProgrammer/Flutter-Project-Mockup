import 'package:flutter/material.dart';

import '../theme.dart';
import 'equalizer_screen.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  static const _durationSec = 180.0; // contoh statis: 3:00
  bool _playing = false;
  bool _liked = false;
  double _position = 50;

  String _fmt(double s) {
    final m = s ~/ 60;
    final r = (s % 60).floor().toString().padLeft(2, '0');
    return '$m:$r';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.5),
            radius: 0.95,
            colors: [AppColors.glow, AppColors.background],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Tutup',
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      iconSize: 30,
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        'SEDANG DIPUTAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Opsi lain',
                      icon: const Icon(Icons.more_horiz),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Flexible: sampul otomatis mengecil di layar pendek (anti overflow).
                Flexible(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.secondary,
                              Color(0xFF6A2CB0),
                            ],
                            stops: [0, 0.6, 1],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x618A2BE2),
                              blurRadius: 64,
                              offset: Offset(0, 28),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Judul Lagu',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.4,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Nama Artis',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      tooltip: 'Favorit',
                      icon: Icon(
                        _liked ? Icons.favorite : Icons.favorite_border,
                        color: AppColors.secondary,
                      ),
                      onPressed: () => setState(() => _liked = !_liked),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Slider(
                  value: _position,
                  max: _durationSec,
                  onChanged: (v) => setState(() => _position = v),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _fmt(_position),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        _fmt(_durationSec),
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: 'Acak',
                      icon: const Icon(Icons.shuffle),
                      color: AppColors.textMuted,
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: 'Sebelumnya',
                      icon: const Icon(Icons.skip_previous_rounded),
                      iconSize: 36,
                      onPressed: () {},
                    ),
                    Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x808A2BE2),
                            blurRadius: 28,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: IconButton(
                        tooltip: _playing ? 'Jeda' : 'Putar',
                        icon: Icon(
                          _playing
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                        ),
                        iconSize: 38,
                        color: Colors.white,
                        onPressed: () => setState(() => _playing = !_playing),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Berikutnya',
                      icon: const Icon(Icons.skip_next_rounded),
                      iconSize: 36,
                      onPressed: () {},
                    ),
                    IconButton(
                      tooltip: 'Ulangi',
                      icon: const Icon(Icons.repeat),
                      color: AppColors.textMuted,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      tooltip: 'Equalizer',
                      icon: const Icon(Icons.tune),
                      color: AppColors.secondary,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EqualizerScreen(),
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Antrean',
                      icon: const Icon(Icons.queue_music),
                      color: AppColors.textMuted,
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
