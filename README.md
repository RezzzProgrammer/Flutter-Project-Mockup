# Soundify

Aplikasi streaming musik mobile (Flutter) dengan arsitektur client-server.
Repositori ini berisi **versi awal**: tampilan UI statis mengikuti mockup Figma.

## Layar yang sudah ada
Login, Beranda, Cari, Koleksi, Profil, Pemutar Lagu, Equalizer.

## Menjalankan
Folder ini belum berisi folder platform (`android/`, `ios/`). Generate sekali saja:

```bash
flutter create . --project-name soundify
flutter pub get
flutter run
```

## Struktur
```
lib/
  main.dart            # entry point + rute
  theme.dart           # warna
  widgets/common.dart  # komponen yang dipakai ulang
  screens/             # satu file per layar
```

## Rencana berikutnya
- Backend REST API (autentikasi JWT, data lagu, playlist)
- Pemutaran audio sungguhan (mis. paket `just_audio`)
- Halaman Daftar dan Login Google
