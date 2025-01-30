import 'package:firebase_auth/firebase_auth.dart';
// debugPrint
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'map_page.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapPage()),
              );
            },
            child: Text("Lihat Peta Perpustakaan"),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user != null
                ? Column(
                    children: [
                      Text("Hello, ${user.displayName}"),
                      SizedBox(height: 10),
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL ?? ""),
                        radius: 40,
                      ),
                    ],
                  )
                : Text("No user signed in"),
          ],
        ),
      ),
    );
  }
}
