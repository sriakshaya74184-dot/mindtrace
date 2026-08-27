import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitPanel extends StatefulWidget {
  const HabitPanel({super.key});

  @override
  State<HabitPanel> createState() =>
      _HabitPanelState();
}

class _HabitPanelState
    extends State<HabitPanel> {

  List<Map<String, dynamic>> habits = [];

  // ================= LOAD HABITS =================

  @override
  void initState() {

    super.initState();

    loadHabits();
  }

  Future<void> loadHabits() async {

    final prefs =
    await SharedPreferences.getInstance();

    final String? habitData =
    prefs.getString("habits");

    if (habitData != null) {

      final List decoded =
      jsonDecode(habitData);

      setState(() {

        habits = decoded
            .map((item) =>
        Map<String, dynamic>.from(item))
            .toList();
      });
    }
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    final completedHabits =
        habits.where(
              (habit) =>
          habit["completed"] == true,
        ).length;

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(
            color:
            Colors.black.withOpacity(0.05),

            blurRadius: 12,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // ================= HEADER =================

          Row(

            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              const Text(

                "Today's Habits",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              Container(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration: BoxDecoration(

                  color:
                  Colors.blue.shade50,

                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Text(

                  "$completedHabits/${habits.length}",

                  style: TextStyle(

                    color:
                    Colors.blue.shade700,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ================= EMPTY =================

          if (habits.isEmpty)

            const Center(

              child: Padding(

                padding:
                EdgeInsets.all(20),

                child: Text(
                  "No habits added yet",
                ),
              ),
            ),

          // ================= HABITS =================

          ...habits.map(

                (habit) => Column(

              children: [

                buildHabitTile(

                  habit["title"],

                  habit["completed"],
                ),

                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= HABIT TILE =================

  Widget buildHabitTile(
      String title,
      bool completed,
      ) {

    return ListTile(

      contentPadding:
      EdgeInsets.zero,

      leading: CircleAvatar(

        backgroundColor:

        completed

            ? Colors.green.shade100

            : Colors.grey.shade200,

        child: Icon(

          completed
              ? Icons.check
              : Icons.access_time,

          color:
          completed
              ? Colors.green
              : Colors.grey,
        ),
      ),

      title: Text(

        title,

        style: const TextStyle(
          fontWeight:
          FontWeight.w600,
        ),
      ),

      subtitle: Text(

        completed
            ? "Completed"
            : "Pending",
      ),
    );
  }
}