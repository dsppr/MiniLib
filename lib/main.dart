import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'views/login_page.dart';
import 'services/auth_service.dart';
import 'views/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  // Debugging: Pastikan API Key terbaca
  String? mapboxToken = dotenv.env['MAPBOX_ACCESS_TOKEN'];
  if (mapboxToken == null || mapboxToken.isEmpty) {
    debugPrint(
        "⚠️ Mapbox API Key tidak ditemukan! Pastikan file .env sudah benar.");
  } else {
    debugPrint("✅ Mapbox API Key berhasil terbaca.");
  }

  User? user = await AuthService().signInSilently();
  runApp(MyApp(initialUser: user));
}

class MyApp extends StatelessWidget {
  final User? initialUser;
  const MyApp({super.key, this.initialUser});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: initialUser != null ? HomePage() : LoginPage(),
    );
  }
}
