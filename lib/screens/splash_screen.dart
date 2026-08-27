import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';
import 'bottom_nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {

    final prefs =
    await SharedPreferences.getInstance();

    bool isLoggedIn =
        prefs.getBool("is_logged_in") ?? false;

    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) return;

    if (isLoggedIn) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>
          const BottomNavScreen(),
        ),
      );

    } else {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>
          const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            const Icon(

              Icons.psychology,

              size: 90,

              color: Colors.blue,
            ),

            const SizedBox(height: 20),

            const Text(

              "MindTrace",

              style: TextStyle(

                fontSize: 32,

                fontWeight: FontWeight.bold,

                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              "Track Your Mind & Wellness",

              style: TextStyle(

                fontSize: 16,

                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            CircularProgressIndicator(
              color: Colors.blue.shade400,
            ),
          ],
        ),
      ),
    );
  }
}