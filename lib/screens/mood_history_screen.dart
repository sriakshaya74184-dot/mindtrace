import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodHistoryScreen extends StatefulWidget {
  const MoodHistoryScreen({super.key});

  @override
  State<MoodHistoryScreen> createState() =>
      _MoodHistoryScreenState();
}

class _MoodHistoryScreenState
    extends State<MoodHistoryScreen> {

  List<Map<String, dynamic>>
  moodHistory = [];

  @override
  void initState() {

    super.initState();

    loadMoodHistory();
  }

  // ================= LOAD HISTORY =================

  Future<void> loadMoodHistory() async {

    final prefs =
    await SharedPreferences.getInstance();

    final data =
    prefs.getString("mood_history");

    if (data != null) {

      final List decoded =
      jsonDecode(data);

      setState(() {

        moodHistory = decoded
            .map<Map<String, dynamic>>(
              (item) => {
            "emoji":
            item["emoji"],

            "mood":
            item["mood"],

            "date":
            item["date"],
          },
        ).toList();
      });
    }
  }

  // ================= DELETE ENTRY =================

  Future<void> deleteMood(
      int index,
      ) async {

    final prefs =
    await SharedPreferences.getInstance();

    setState(() {

      moodHistory.removeAt(index);
    });

    await prefs.setString(
      "mood_history",
      jsonEncode(moodHistory),
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
          "Mood History",
        ),

        centerTitle: true,
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: moodHistory.isEmpty

            ? const Center(

          child: Text(

            "No mood history yet",

            style: TextStyle(
              fontSize: 18,
            ),
          ),
        )

            : ListView.builder(

          itemCount:
          moodHistory.length,

          itemBuilder:
              (context, index) {

            final mood =
            moodHistory[index];

            return Container(

              margin:
              const EdgeInsets.only(
                  bottom: 18),

              padding:
              const EdgeInsets.all(
                  18),

              decoration:
              BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(
                    22),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(
                        0.05),

                    blurRadius: 10,

                    offset:
                    const Offset(
                        0, 4),
                  ),
                ],
              ),

              child: Row(

                children: [

                  // ================= EMOJI =================

                  Container(

                    width: 70,
                    height: 70,

                    decoration:
                    BoxDecoration(

                      color:
                      Colors.blue
                          .shade50,

                      shape:
                      BoxShape.circle,
                    ),

                    child: Center(

                      child: Text(

                        mood["emoji"],

                        style:
                        const TextStyle(
                          fontSize: 34,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  // ================= DETAILS =================

                  Expanded(

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        Text(

                          mood["mood"],

                          style:
                          const TextStyle(

                            fontSize: 22,

                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),

                        const SizedBox(
                            height: 8),

                        Text(

                          mood["date"],

                          style:
                          const TextStyle(

                            color:
                            Colors.grey,

                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ================= DELETE =================

                  IconButton(

                    onPressed: () {

                      deleteMood(index);
                    },

                    icon: const Icon(

                      Icons.delete,

                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}