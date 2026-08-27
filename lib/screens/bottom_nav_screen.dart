import 'package:flutter/material.dart';

import 'home/dashboard_screen.dart';
import 'habit_screen.dart';
import 'focus_relax/focus_relax_screen.dart';
import 'profile/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() =>
      _BottomNavScreenState();
}

class _BottomNavScreenState
    extends State<BottomNavScreen> {

  int currentIndex = 0;

  // ================= SCREENS =================

  final List<Widget> screens = [

    DashboardScreen(),

    HabitScreen(),

    FocusRelaxScreen(),

    ProfileScreen(),
  ];

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {

            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.blue,

        unselectedItemColor: Colors.grey,

        selectedLabelStyle:
        const TextStyle(
          fontWeight: FontWeight.bold,
        ),

        items: const [

          BottomNavigationBarItem(

            icon: Icon(Icons.home),

            label: "Home",
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.check_circle),

            label: "Habits",
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.sports_esports),

            label: "Focus & Relax",
          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.person),

            label: "Profile",
          ),
        ],
      ),
    );
  }
}