
import 'package:flutter/material.dart';
import 'bubble_pop_game.dart';
import 'thought_sorting_game.dart';
import 'opposite_thought_challenge.dart';
import 'emotion_match_game.dart';
class FocusRelaxScreen extends StatefulWidget {
  const FocusRelaxScreen({super.key});

  @override
  State<FocusRelaxScreen> createState() =>
      _FocusRelaxScreenState();
}

class _FocusRelaxScreenState
    extends State<FocusRelaxScreen> {

  final List<Map<String, dynamic>> relaxItems = [

    {
      "title": "Bubble Relax",
      "subtitle": "Pop stressful thoughts",
      "icon": Icons.bubble_chart,
      "color": Colors.blue,
    },
    {
      "title": "Thought Sorting",
      "subtitle": "Practice healthy thinking",
      "icon": Icons.psychology,
      "color": Colors.green,
    },
    {
      "title": "Thought Challenge",
      "subtitle": "Replace negative thoughts",
      "icon": Icons.psychology,
      "color": Colors.indigo,
    },
    {
      "title": "Emotion Match",
      "subtitle": "Match emotions and responses",
      "icon": Icons.favorite,
      "color": Colors.pink,
    },
  ];

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

            padding: const EdgeInsets.all(24),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                // ================= HEADER =================

                Row(

                  children: [

                    IconButton(

                      onPressed: () {
                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),

                    const Expanded(

                      child: Text(

                        "Focus & Relax",

                        textAlign: TextAlign.center,
                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(

                          fontSize: 28,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 40),
                  ],
                ),

                const SizedBox(height: 30),

                // ================= QUOTE CARD =================

                Container(

                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(24),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(28),

                    boxShadow: [

                      BoxShadow(

                        color:
                        Colors.black.withOpacity(
                            0.05),

                        blurRadius: 15,

                        offset:
                        const Offset(0, 6),
                      ),
                    ],
                  ),

                  child: Column(

                    children: [

                      CircleAvatar(

                        radius: 35,

                        backgroundColor:
                        Colors.blue.shade100,

                        child: const Icon(

                          Icons.self_improvement,

                          size: 40,

                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(height: 14),

                      const Text(

                        "Relax your mind,\nfocus your energy 🌿",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 24,

                          fontWeight:
                          FontWeight.bold,

                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(

                        "Take a moment to breathe,\ncalm down and refresh yourself.",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          fontSize: 16,

                          color: Colors.grey,

                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 35),

                // ================= SECTION TITLE =================

                const Text(

                  "Relax Activities",

                  style: TextStyle(

                    fontSize: 24,

                    fontWeight: FontWeight.bold,
                  ),
                ),


                const SizedBox(height: 14),

                // ================= GRID =================

                GridView.builder(

                  shrinkWrap: true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  itemCount: relaxItems.length,

                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 2,

                    crossAxisSpacing: 18,

                    mainAxisSpacing: 18,

                    childAspectRatio: 0.60,
                  ),

                  itemBuilder: (context, index) {

                    final item = relaxItems[index];

                    return GestureDetector(

                      onTap: () {
                        print(item["title"]);
                        if (item["title"] == "Bubble Relax") {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BubblePopGame(),
                            ),
                          );

                        }
                        else if (item["title"] == "Thought Sorting") {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (context) =>
                              const ThoughtSortingGame(),
                            ),
                          );

                        }
                        else if (item["title"] == "Thought Challenge") {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (context) =>
                              const OppositeThoughtChallenge(),
                            ),
                          );
                        }
                        else if (item["title"] == "Emotion Match") {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (context) =>
                              const EmotionMatchGame(),
                            ),
                          );
                        }
                      },

                      child: Container(

                        padding:
                        const EdgeInsets.all(20),

                        decoration: BoxDecoration(

                          color: Colors.white,

                          borderRadius:
                          BorderRadius.circular(28),

                          boxShadow: [

                            BoxShadow(

                              color: Colors.black
                                  .withOpacity(0.05),

                              blurRadius: 12,

                              offset:
                              const Offset(0, 5),
                            ),
                          ],
                        ),

                        child: Column(

                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            Container(

                              padding:
                              const EdgeInsets.all(18),

                              decoration: BoxDecoration(

                                color: item["color"]
                                    .withOpacity(0.12),

                                shape: BoxShape.circle,
                              ),

                              child: Icon(

                                item["icon"],

                                size: 40,

                                color: item["color"],
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(

                              item["title"],

                              textAlign:
                              TextAlign.center,

                              style: const TextStyle(

                                fontSize: 18,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              item["subtitle"],

                              textAlign: TextAlign.center,

                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 35),

                // ================= DAILY TIP =================

                Container(

                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(22),

                  decoration: BoxDecoration(

                    gradient: LinearGradient(

                      colors: [

                        Colors.blue.shade300,

                        Colors.purple.shade300,
                      ],
                    ),

                    borderRadius:
                    BorderRadius.circular(26),
                  ),

                  child: const Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(

                        "Daily Relax Tip 🌸",

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 22,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(

                        "Spend 5 minutes away from screens and focus only on your breathing.",

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 16,

                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}