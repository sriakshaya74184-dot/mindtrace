import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() =>
      _HabitScreenState();
}

class _HabitScreenState
    extends State<HabitScreen> {

  final TextEditingController
  habitController =
  TextEditingController();

  List<Map<String, dynamic>> habits = [];

  // ================= INIT =================

  @override
  void initState() {

    super.initState();

    loadHabits();
  }

  // ================= LOAD =================

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

    } else {

      setState(() {

        habits = [

          {
            "title": "Drink Water 💧",
            "completed": false,
          },

          {
            "title": "Meditation 🧘",
            "completed": false,
          },

          {
            "title": "Exercise 🏃",
            "completed": false,
          },

          {
            "title": "Sleep Early 😴",
            "completed": false,
          },

          {
            "title": "Journal Writing 📔",
            "completed": false,
          },
        ];
      });

      saveHabits();
    }
  }

  // ================= SAVE =================

  Future<void> saveHabits() async {

    final prefs =
    await SharedPreferences.getInstance();

    prefs.setString(
      "habits",
      jsonEncode(habits),
    );
  }

  // ================= ADD HABIT =================

  void addHabit() {

    if (habitController.text
        .trim()
        .isNotEmpty) {

      setState(() {

        habits.add({

          "title":
          habitController.text.trim(),

          "completed": false,
        });
      });

      saveHabits();

      habitController.clear();
    }
  }

  // ================= PROGRESS =================

  int get completedHabits {

    return habits
        .where((habit) =>
    habit["completed"] == true)
        .length;
  }

  String get motivationMessage {

    final completed =
        completedHabits;

    if (completed == habits.length) {

      return
        "Perfect day! Amazing consistency 🔥";
    }

    if (completed >= 3) {

      return
        "You're building healthy routines 🌱";
    }

    if (completed >= 1) {

      return
        "Good progress! Keep going ✨";
    }

    return
      "Start small, stay consistent 💙";
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F8FC),

      appBar: AppBar(

        title: const Text(
          "Habit Tracker",
        ),

        centerTitle: true,
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            // ================= PROGRESS CARD =================

            Container(

              width: double.infinity,

              padding:
              const EdgeInsets.all(22),

              decoration: BoxDecoration(

                gradient: LinearGradient(

                  colors: [

                    Colors.blue.shade50,

                    Colors.purple.shade50,
                  ],
                ),

                borderRadius:
                BorderRadius.circular(24),
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  const Text(

                    "Today's Progress",

                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(

                    "$completedHabits / ${habits.length} habits completed",

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  LinearProgressIndicator(

                    value:
                    habits.isEmpty
                        ? 0
                        : completedHabits /
                        habits.length,

                    minHeight: 10,

                    borderRadius:
                    BorderRadius.circular(20),
                  ),

                  const SizedBox(height: 18),

                  Text(

                    motivationMessage,

                    style: TextStyle(
                      fontSize: 15,
                      color:
                      Colors.grey.shade700,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= ADD HABIT =================

            TextField(

              controller:
              habitController,

              decoration:
              InputDecoration(

                hintText:
                "Add a new habit",

                prefixIcon:
                const Icon(Icons.add_task),

                suffixIcon:
                IconButton(

                  icon: const Icon(
                    Icons.add,
                  ),

                  onPressed: addHabit,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ================= HABITS =================

            Expanded(

              child: ListView.builder(

                itemCount: habits.length,

                itemBuilder:
                    (context, index) {

                  return Container(

                    margin:
                    const EdgeInsets.only(
                      bottom: 15,
                    ),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                          20),

                      boxShadow: [

                        BoxShadow(

                          color:
                          Colors.black12,

                          blurRadius: 8,

                          offset:
                          const Offset(
                              0, 4),
                        ),
                      ],
                    ),

                    child: CheckboxListTile(

                      title: Text(

                        habits[index]["title"],

                        style:
                        const TextStyle(
                          fontSize: 16,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),

                      value:
                      habits[index]
                      ["completed"],

                      activeColor:
                      Colors.blue,

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(
                            12),
                      ),

                      onChanged: (value) {

                        setState(() {

                          habits[index]
                          ["completed"] =
                              value;
                        });

                        saveHabits();
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}