import '../focus_relax/focus_relax_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../widgets/auto_slider.dart';
import '../../widgets/dashboard_header.dart';
import '../../widgets/drawer_widget.dart';
import '../../widgets/mood_graph.dart';
import '../../widgets/reflection_card.dart';

import 'habit_panel.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final username =
        user?.email
            ?.split('@')
            .first
            .substring(0, 5) ??
            "User";

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      drawer: DrawerWidget(
        username: username,
      ),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,

        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        title: const Text(
          "MindTrace",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // ================= HEADER =================

              DashboardHeader(
                username: username,
              ),

              const SizedBox(height: 20),

              // ================= QUOTES =================

              const AutoSlider(),

              const SizedBox(height: 20),

              // ================= MOOD GRAPH =================

              const MoodGraph(),

              const SizedBox(height: 20),

              // ================= HABITS =================

              const Text(
                "Today's Habits",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const HabitPanel(),

              const SizedBox(height: 20),

              // ================= VOICE OF THE DAY =================

              const ReflectionCard(),

              const SizedBox(height: 20),

              // ================= FOCUS & RELAX =================

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const FocusRelaxScreen(),
                    ),
                  );
                },

                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade300,
                        Colors.purple.shade300,
                      ],
                    ),

                    borderRadius:
                    BorderRadius.circular(24),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color:
                          Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.self_improvement,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),

                      const SizedBox(width: 16),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Focus & Relax",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "4 wellness games for focus & relaxation 🌿",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}