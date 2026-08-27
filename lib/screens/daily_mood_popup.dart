import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_nav_screen.dart';

class DailyMoodPopup extends StatefulWidget {
  const DailyMoodPopup({super.key});

  @override
  State<DailyMoodPopup> createState() =>
      _DailyMoodPopupState();
}

class _DailyMoodPopupState
    extends State<DailyMoodPopup> {

  String selectedMood = "";

  final List<Map<String, dynamic>> moods = [

    {
      "emoji": "😄",
      "text": "Happy",
      "color": Colors.orange,
    },

    {
      "emoji": "🙂",
      "text": "Good",
      "color": Colors.green,
    },

    {
      "emoji": "😐",
      "text": "Normal",
      "color": Colors.blue,
    },

    {
      "emoji": "😔",
      "text": "Sad",
      "color": Colors.purple,
    },

    {
      "emoji": "😡",
      "text": "Angry",
      "color": Colors.red,
    },
  ];

  Future<void> saveMood() async {

    if (selectedMood.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please select your mood",
          ),
        ),
      );
      return;
    }

    final prefs =
    await SharedPreferences.getInstance();

    final today = DateTime.now();

    final formattedDate =
        "${today.day}/${today.month}/${today.year}";

    await prefs.setString(
      "daily_mood",
      selectedMood,
    );

    await prefs.setString(
      "mood_date",
      today.toString().split(" ")[0],
    );

    String selectedEmoji = "";

    for (var mood in moods) {
      if (mood["text"] == selectedMood) {
        selectedEmoji = mood["emoji"];
      }
    }

    List<Map<String, dynamic>>
    moodHistory = [];

    final existing =
    prefs.getString("mood_history");

    if (existing != null) {
      final List decoded =
      jsonDecode(existing);

      moodHistory = decoded
          .map<Map<String, dynamic>>(
            (item) =>
        Map<String, dynamic>.from(item),
      )
          .toList();
    }

    moodHistory.insert(
      0,
      {
        "emoji": selectedEmoji,
        "mood": selectedMood,
        "date": formattedDate,
      },
    );

    await prefs.setString(
      "mood_history",
      jsonEncode(moodHistory),
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const BottomNavScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Colors.blue.shade100,

              Colors.purple.shade50,

              Colors.white,
            ],
          ),
        ),

        child: SafeArea(

          child: SingleChildScrollView(

            child: Padding(

              padding:
              const EdgeInsets.all(24),

              child: Container(

                width: double.infinity,

                padding:
                const EdgeInsets.all(28),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(30),

                  boxShadow: [

                    BoxShadow(

                      color:
                      Colors.black.withOpacity(
                          0.08),

                      blurRadius: 18,

                      offset:
                      const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    CircleAvatar(

                      radius: 40,

                      backgroundColor:
                      Colors.blue.shade100,

                      child: const Icon(

                        Icons.favorite,

                        color: Colors.blue,

                        size: 40,
                      ),
                    ),

                    const SizedBox(
                        height: 25),

                    const Text(

                      "How are you\nfeeling today?",

                      textAlign:
                      TextAlign.center,

                      style: TextStyle(

                        fontSize: 28,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 12),

                    const Text(

                      "Track your emotions\nand improve wellness 🌿",

                      textAlign:
                      TextAlign.center,

                      style: TextStyle(

                        color: Colors.grey,

                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(
                        height: 30),

                    Wrap(

                      spacing: 12,

                      runSpacing: 12,

                      children:
                      moods.map((mood) {

                        bool selected =
                            selectedMood ==
                                mood["text"];

                        return GestureDetector(

                          onTap: () {

                            setState(() {

                              selectedMood =
                              mood["text"];
                            });
                          },

                          child:
                          AnimatedContainer(

                            duration:
                            const Duration(
                                milliseconds:
                                250),

                            padding:
                            const EdgeInsets.all(
                                16),

                            decoration:
                            BoxDecoration(

                              color: selected

                                  ? mood["color"]
                                  .withOpacity(
                                  0.15)

                                  : Colors.grey
                                  .shade100,

                              borderRadius:
                              BorderRadius
                                  .circular(
                                  18),

                              border: Border.all(

                                color: selected

                                    ? mood["color"]

                                    : Colors
                                    .transparent,

                                width: 2,
                              ),
                            ),

                            child: Column(

                              children: [

                                Text(

                                  mood["emoji"],

                                  style:
                                  const TextStyle(
                                    fontSize: 34,
                                  ),
                                ),

                                const SizedBox(
                                    height: 8),

                                Text(

                                  mood["text"],

                                  style:
                                  const TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(
                        height: 30),

                    SizedBox(

                      width:
                      double.infinity,

                      height: 58,

                      child:
                      ElevatedButton(

                        onPressed:
                        saveMood,

                        style:
                        ElevatedButton
                            .styleFrom(

                          backgroundColor:
                          Colors.blue,

                          shape:
                          RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius
                                .circular(
                                18),
                          ),
                        ),

                        child:
                        const Text(

                          "Continue",

                          style:
                          TextStyle(

                            color:
                            Colors.white,

                            fontSize: 18,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}