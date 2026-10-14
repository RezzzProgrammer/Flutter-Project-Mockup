import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/common.dart';

class EqualizerScreen extends StatefulWidget {
  const EqualizerScreen({super.key});

  @override
  State<EqualizerScreen> createState() => _EqualizerScreenState();
}

class _EqualizerScreenState extends State<EqualizerScreen> {
  static const _bands = ['60', '230', '910', '3.6k', '14k', '16k'];

  static const _presets = <String, List<double>>{
    'Normal': [0, 0, 0, 0, 0, 0],
    'Bass Boost': [6, 4, 1, 0, 0, 0],
    'Vokal': [-2, 0, 3, 4, 2, 0],
    'Pop': [-1, 2, 4, 3, 1, -1],
    'Rock': [4, 3, -1, -2, 2, 4],
  };

  bool _enabled = true;
  String _preset = 'Kustom';
  List<double> _gains = [0, 4, 2, -3, 5, 3];

  String _label(double g) => g > 0 ? '+${g.round()}' : '${g.round()}';

  void _applyPreset(String name) {
    setState(() {
      _preset = name;
      _gains = List<double>.from(_presets[name]!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Equalizer',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.line),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Aktifkan equalizer',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Atur 6 pita frekuensi (Hz)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _enabled,
                          activeThumbColor: Colors.white,
                          activeTrackColor: AppColors.primary,
                          onChanged: (v) => setState(() => _enabled = v),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var i = 0; i < _bands.length; i++)
                            SizedBox(
                              width: 44,
                              child: Column(
                                children: [
                                  Text(
                                    _label(_gains[i]),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                    ),
                                  ),
                                  Expanded(
                                    child: RotatedBox(
                                      quarterTurns: 3,
                                      child: Slider(
                                        value: _gains[i],
                                        min: -12,
                                        max: 12,
                                        divisions: 24,
                                        onChanged: _enabled
                                            ? (v) => setState(() {
                                                  _gains[i] = v;
                                                  _preset = 'Kustom';
                                                })
                                            : null,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _bands[i],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SectionTitle('Preset', top: 26),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final name in [..._presets.keys, 'Kustom'])
                    AppChip(
                      label: name,
                      selected: name == _preset,
                      onTap: name == 'Kustom' ? null : () => _applyPreset(name),
                    ),
                ],
              ),
              const SizedBox(height: 28),
              FilledButton(
                style: AppButtons.outlined,
                onPressed: () => _applyPreset('Normal'),
                child: const Text('Setel ulang'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
