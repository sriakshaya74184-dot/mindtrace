import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  String userName = "MindTrace User";

  @override
  void initState() {

    super.initState();

    loadUserData();

  }


  Future<void> loadUserData() async {

    final prefs =
    await SharedPreferences.getInstance();

    setState(() {
      userName =
          prefs.getString("user_name") ??
              "MindTrace User";
    });
  }

  String getGreeting() {

    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Ready for a fresh start today?";
    }

    if (hour < 17) {
      return "Stay focused and keep moving!";
    }

    if (hour < 21) {
      return "You are doing great today.";
    }

    return "Take a moment to relax and recharge.";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("MindTrace"),
        centerTitle: true,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            // ================= WELCOME CARD =================

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: Colors.blue.shade50,

                borderRadius:
                BorderRadius.circular(22),
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Text(

                    "Welcome Back,",

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(

                    userName,

                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(

                    getGreeting(),

                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: GridView.count(

                crossAxisCount: 2,

                crossAxisSpacing: 15,

                mainAxisSpacing: 15,

                children: [

                  buildCard(
                    Icons.mood,
                    "Mood Tracker",
                  ),

                  buildCard(
                    Icons.menu_book,
                    "Memory Journal",
                  ),

                  buildCard(
                    Icons.timer,
                    "Focus Mode",
                  ),

                  buildCard(
                    Icons.task,
                    "Tasks",
                  ),

                  buildCard(
                    Icons.favorite,
                    "Habits",
                  ),

                  buildCard(
                    Icons.self_improvement,
                    "Meditation",
                  ),

                  buildCard(
                    Icons.health_and_safety,
                    "Mental Health",
                  ),

                  buildCard(
                    Icons.phone,
                    "Emergency",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
      IconData icon,
      String title) {

    return Container(

      decoration: BoxDecoration(

        color: Colors.blue.shade50,

        borderRadius:
        BorderRadius.circular(20),
      ),

      child: Column(

        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            size: 45,
            color: Colors.blue,
          ),

          const SizedBox(height: 15),

          Text(

            title,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}