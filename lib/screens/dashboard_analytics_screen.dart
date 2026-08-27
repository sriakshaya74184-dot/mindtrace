import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardAnalyticsScreen
    extends StatefulWidget {

  const DashboardAnalyticsScreen({
    super.key,
  });

  @override
  State<DashboardAnalyticsScreen>
  createState() =>
      _DashboardAnalyticsScreenState();
}

class _DashboardAnalyticsScreenState
    extends State<
        DashboardAnalyticsScreen> {

  int totalMoodEntries = 0;

  int totalJournalEntries = 0;

  int completedHabits = 0;

  int totalHabits = 0;

  String mostSelectedMood = "🙂";

  @override
  void initState() {

    super.initState();

    loadAnalytics();
  }

  // ================= LOAD DATA =================

  Future<void> loadAnalytics() async {

    final prefs =
    await SharedPreferences.getInstance();

    // ================= MOOD HISTORY =================

    final moodData =
    prefs.getString("mood_history");

    if (moodData != null) {

      final List decoded =
      jsonDecode(moodData);

      totalMoodEntries =
          decoded.length;

      Map<String, int> moodCount = {};

      for (var mood in decoded) {

        String emoji =
        mood["emoji"];

        moodCount[emoji] =
            (moodCount[emoji] ?? 0) + 1;
      }

      if (moodCount.isNotEmpty) {

        mostSelectedMood =
            moodCount.entries
                .reduce(
                  (a, b) =>
              a.value > b.value
                  ? a
                  : b,
            ).key;
      }
    }

    // ================= JOURNAL =================

    final journalData =
    prefs.getString(
        "journal_entries");

    if (journalData != null) {

      final List decoded =
      jsonDecode(journalData);

      totalJournalEntries =
          decoded.length;
    }

    // ================= HABITS =================

    final habitData =
    prefs.getString("habits");

    if (habitData != null) {

      final List decoded =
      jsonDecode(habitData);

      totalHabits =
          decoded.length;

      completedHabits =
          decoded.where((habit) {

            return habit["completed"]
                == true;

          }).length;
    }

    setState(() {});
  }

  // ================= CARD =================

  Widget buildCard({

    required String title,

    required String value,

    required IconData icon,

    required Color color,
  }) {

    return Container(

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(

            color:
            Colors.black.withOpacity(
                0.05),

            blurRadius: 10,

            offset:
            const Offset(0, 4),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          CircleAvatar(

            radius: 24,

            backgroundColor:
            color.withOpacity(0.15),

            child: Icon(
              icon,
              color: color,
            ),
          ),

          const SizedBox(height: 18),

          Text(

            value,

            style: const TextStyle(

              fontSize: 28,

              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(

            title,

            style: const TextStyle(

              color: Colors.grey,

              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F8FC),

      appBar: AppBar(

        title: const Text(
          "Analytics Dashboard",
        ),

        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // ================= HEADER =================

            Container(

              width: double.infinity,

              padding:
              const EdgeInsets.all(24),

              decoration: BoxDecoration(

                gradient: LinearGradient(

                  colors: [

                    Colors.blue.shade400,

                    Colors.purple.shade300,
                  ],
                ),

                borderRadius:
                BorderRadius.circular(
                    30),
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Your Wellness",

                    style: TextStyle(

                      color: Colors.white70,

                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(

                    "MindTrace Analytics",

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 28,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(

                    children: [

                      const Text(

                        "Most Selected Mood:",

                        style: TextStyle(

                          color:
                          Colors.white,

                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Text(

                        mostSelectedMood,

                        style: const TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= GRID =================

            GridView.count(

              shrinkWrap: true,

              physics:
              const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,

              crossAxisSpacing: 16,

              mainAxisSpacing: 16,

              childAspectRatio: 1,

              children: [

                buildCard(

                  title:
                  "Mood Entries",

                  value:
                  totalMoodEntries
                      .toString(),

                  icon:
                  Icons.mood,

                  color:
                  Colors.orange,
                ),

                buildCard(

                  title:
                  "Journal Notes",

                  value:
                  totalJournalEntries
                      .toString(),

                  icon:
                  Icons.menu_book,

                  color:
                  Colors.blue,
                ),

                buildCard(

                  title:
                  "Completed Habits",

                  value:
                  completedHabits
                      .toString(),

                  icon:
                  Icons.check_circle,

                  color:
                  Colors.green,
                ),

                buildCard(

                  title:
                  "Total Habits",

                  value:
                  totalHabits
                      .toString(),

                  icon:
                  Icons.track_changes,

                  color:
                  Colors.purple,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ================= PROGRESS =================

            Container(

              padding:
              const EdgeInsets.all(24),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(
                    28),

                boxShadow: [

                  BoxShadow(

                    color:
                    Colors.black.withOpacity(
                        0.05),

                    blurRadius: 10,

                    offset:
                    const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Habit Progress",

                    style: TextStyle(

                      fontSize: 22,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  LinearProgressIndicator(

                    value:
                    totalHabits == 0

                        ? 0

                        : completedHabits /
                        totalHabits,

                    minHeight: 14,

                    borderRadius:
                    BorderRadius.circular(
                        20),

                    backgroundColor:
                    Colors.grey.shade300,

                    valueColor:
                    AlwaysStoppedAnimation(
                      Colors.green,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(

                    "$completedHabits of $totalHabits habits completed",

                    style: const TextStyle(

                      color: Colors.grey,

                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}