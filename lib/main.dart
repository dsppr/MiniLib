import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'views/login_page.dart';
import 'services/auth_service.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inisialisasi Firebase
    await Firebase.initializeApp();

    // Jika kamu menggunakan dotenv untuk Mapbox atau konfigurasi lain, tambahkan ini:
    await dotenv.load(fileName: ".env");

    // Aktifkan Firebase App Check
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug, // Hanya untuk debug mode
    );

    // Cek apakah Mapbox API Key terbaca (jika ada)
    String? mapboxToken = dotenv.env['MAPBOX_ACCESS_TOKEN'];
    if (mapboxToken == null || mapboxToken.isEmpty) {
      debugPrint("⚠️ Mapbox API Key tidak ditemukan! Periksa file .env");
    } else {
      debugPrint("✅ Mapbox API Key terbaca dengan sukses.");
    }

    // Coba login otomatis dengan Firebase Authentication
    User? user = await AuthService().signInSilently();

    runApp(MyApp(initialUser: user));
  } catch (e) {
    debugPrint("🔥 Terjadi error saat inisialisasi: $e");
  }
}

class MyApp extends StatelessWidget {
  final User? initialUser;
  const MyApp({super.key, this.initialUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MiniLib',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: initialUser != null ? HomePage() : LoginPage(),
    );
  }
}
