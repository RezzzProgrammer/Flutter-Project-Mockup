##Wavelet

Aplikasi streaming musik mobile (Flutter) dengan arsitektur client-server.
Repositori ini berisi **versi kedua**: yang sudah bisa menggunakan fitur login dan registrasi yang terintegrasi dengan backend

## Layar yang sudah ada
Login, Registrasi, Beranda, Cari, Koleksi, Profil, Pemutar Lagu, Equalizer.

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
  models/
    app_user.dart
  screens/
    equalizer_screnn.dart
    home_screen.dart
    home_shell.dart
    library_screen.dart
    login_screen.dart
    player_screen.dart
    profile_screen.dart
    register_screen.dart
    search_screen.dart
    splash_screen.dart
  services/
    api_services.dart
    session.dart
  widgets/
    common.dart
  config.dart
  main.dart
  theme.dart           
```

## Rencana berikutnya
- Backend REST API (autentikasi JWT, data lagu, playlist)
- Pemutaran audio sungguhan (mis. paket `just_audio`)
- Login Menggunakan Google

##Repositories untuk Backend
  https://github.com/RezzzProgrammer/Wavelet-Backend
