import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home/dashboard_screen.dart';
import '../screens/mood_screen.dart';
import '../screens/habit_screen.dart';
import '../screens/journal_screen.dart';
import '../screens/meditation_screen.dart';
import '../screens/emergency_screen.dart';
import '../screens/login_screen.dart';

class DrawerWidget extends StatelessWidget {
  final String username;

  const DrawerWidget({
    super.key,
    required this.username,
  });

  Future<void> logout(BuildContext context) async {
    final prefs =
    await SharedPreferences.getInstance();

    // remove only login session
    await prefs.remove("is_logged_in");

    if (!context.mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const LoginScreen(),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(

        padding: EdgeInsets.zero,

        children: [

          // HEADER
          Container(

            width: double.infinity,

            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
              bottom: 20,
            ),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.shade200,
                  Colors.purple.shade200,
                ],
              ),
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const Icon(
                  Icons.psychology,
                  size: 55,
                  color: Colors.white,
                ),

                const SizedBox(height: 16),

                Text(

                  username.isEmpty
                      ? "MindTrace User"
                      : username,

                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight:
                    FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(

                  "MindTrace Wellness App",

                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          buildTile(
            context,
            Icons.home,
            "Home",
            DashboardScreen(),
          ),

          buildTile(
            context,
            Icons.mood,
            "Mood Tracker",
            const MoodScreen(),
          ),

          buildTile(
            context,
            Icons.favorite,
            "Habit Tracker",
            const HabitScreen(),
          ),

          buildTile(
            context,
            Icons.menu_book,
            "Memory Journal",
            const JournalScreen(),
          ),

          buildTile(
            context,
            Icons.self_improvement,
            "Meditation",
            const MeditationScreen(),
          ),

          buildTile(
            context,
            Icons.warning,
            "Emergency Support",
            const EmergencyScreen(),
          ),

          const Divider(),

          // LOGOUT
          ListTile(

            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),

            title: const Text(
              "Logout",
            ),

            onTap: () async {

              final confirm =
              await showDialog<bool>(

                context: context,

                builder: (_) =>
                    AlertDialog(

                      title:
                      const Text(
                          "Logout"),

                      content:
                      const Text(
                          "Do you want to logout?"),

                      actions: [

                        TextButton(

                          onPressed: () {

                            Navigator.pop(
                                context,
                                false);
                          },

                          child:
                          const Text(
                              "Cancel"),
                        ),

                        ElevatedButton(

                          onPressed: () {

                            Navigator.pop(
                                context,
                                true);
                          },

                          child:
                          const Text(
                              "Logout"),
                        ),
                      ],
                    ),
              );

              if (confirm == true) {
                await logout(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildTile(
      BuildContext context,
      IconData icon,
      String title,
      Widget screen,
      ) {
    return ListTile(

      leading: Icon(icon),

      title: Text(title),

      onTap: () {

        Navigator.pop(context);

        Navigator.push(

          context,

          MaterialPageRoute(
            builder: (_) => screen,
          ),
        );
      },
    );
  }
}