import 'dart:async';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class BubblePopGame extends StatefulWidget {
  const BubblePopGame({super.key});

  @override
  State<BubblePopGame> createState() =>
      _BubblePopGameState();
}

class _BubblePopGameState
    extends State<BubblePopGame> {
  Future<void> loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      highScore = prefs.getInt('bubble_high_score') ?? 0;
    });
  }
  @override
  void initState() {
    super.initState();
    loadHighScore();
  }
  final Random random = Random();

  List<StressBubble> bubbles = [];

  int stressReleased = 0;

  int highScore = 0;

  int timeLeft = 40;

  bool gameStarted = false;

  String affirmation = "";

  Timer? gameTimer;

  Timer? bubbleTimer;

  final List<String> stressThoughts = [

    "Stress",

    "Fear",

    "Pressure",

    "Anxiety",

    "Burnout",

    "Overthinking",

    "Sadness",
  ];

  final List<String> affirmations = [

    "🌿 Let it go",

    "✨ Stay calm",

    "☀️ Breathe deeply",

    "💙 You are enough",

    "🌸 Relax your mind",

    "🕊️ Peace begins here",
  ];

  // ================= START GAME =================

  void startGame() {

    setState(() {

      stressReleased = 0;

      timeLeft = 40;

      bubbles.clear();

      affirmation = "";

      gameStarted = true;
    });

    // ================= GAME TIMER =================

    gameTimer?.cancel();

    gameTimer = Timer.periodic(

      const Duration(seconds: 1),

          (timer) {

        if (timeLeft > 0) {

          setState(() {

            timeLeft--;
          });

        } else {

          timer.cancel();

          bubbleTimer?.cancel();

          Future<void> saveHighScore() async {
            if (stressReleased > highScore) {

              highScore = stressReleased;

              final prefs =
              await SharedPreferences.getInstance();

              await prefs.setInt(
                'bubble_high_score',
                highScore,
              );
            }
            await saveHighScore();
            showGameComplete();
          }

          showGameComplete();
        }
      },
    );

    // ================= BUBBLE CREATOR =================

    bubbleTimer?.cancel();

    bubbleTimer = Timer.periodic(

      const Duration(milliseconds: 900),

          (timer) {

        setState(() {

          bubbles.add(

            StressBubble(

              x: random.nextDouble(),

              y: random.nextDouble(),

              size:
              random.nextDouble() * 40 + 70,

              color: Colors.primaries[
              random.nextInt(
                  Colors.primaries.length)],

              text: stressThoughts[
              random.nextInt(
                  stressThoughts.length)],
            ),
          );

          if (bubbles.length > 10) {

            bubbles.removeAt(0);
          }
        });
      },
    );
  }

  // ================= POP BUBBLE =================

  void popBubble(int index) {

    setState(() {

      stressReleased++;

      affirmation = affirmations[
      random.nextInt(
          affirmations.length)];

      bubbles.removeAt(index);
    });
  }

  // ================= GAME COMPLETE =================

  void showGameComplete() {

    showDialog(

      context: context,

      barrierDismissible: false,

      builder: (context) {

        return AlertDialog(

          shape: RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(25),
          ),

          title: Row(

            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              const Text(
                "Session Complete 🌿",
              ),

              GestureDetector(

                onTap: () {

                  Navigator.pop(context);

                  Navigator.pop(context);
                },

                child: const Icon(

                  Icons.close,

                  color: Colors.red,
                ),
              ),
            ],
          ),

          content: Column(

            mainAxisSize:
            MainAxisSize.min,

            children: [

              Text(

                "✨ You released $stressReleased stressful thoughts",
              ),

              const SizedBox(height: 15),

              Text(

                "🏆 High Score: $highScore",
              ),

              const SizedBox(height: 15),

              const Text(

                "☀️ Your mind feels lighter",
              ),
            ],
          ),

          actions: [

            ElevatedButton(

              onPressed: () {

                Navigator.pop(context);

                startGame();
              },

              child: const Text(
                "Play Again",
              ),
            ),
          ],
        );
      },
    );
  }

  // ================= DISPOSE =================

  @override
  void dispose() {

    gameTimer?.cancel();

    bubbleTimer?.cancel();

    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF6F8FF),

      appBar: AppBar(

        title: const Text(
          "Stress Release Therapy",
        ),

        centerTitle: true,
      ),

      body: Column(

        children: [

          // ================= TOP CARDS =================

          Padding(

            padding:
            const EdgeInsets.all(20),

            child: Row(

              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,

              children: [

                buildInfoCard(

                  "Released",

                  stressReleased.toString(),

                  Colors.blue,
                ),

                buildInfoCard(

                  "High Score",

                  highScore.toString(),

                  Colors.orange,
                ),

                buildInfoCard(

                  "Time",

                  "$timeLeft s",

                  Colors.purple,
                ),
              ],
            ),
          ),

          // ================= AFFIRMATION =================

          if (affirmation.isNotEmpty)

            Padding(

              padding:
              const EdgeInsets.symmetric(
                  horizontal: 20),

              child: Container(

                width: double.infinity,

                padding:
                const EdgeInsets.all(16),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(20),

                  boxShadow: [

                    BoxShadow(

                      color:
                      Colors.black.withOpacity(
                          0.05),

                      blurRadius: 10,
                    ),
                  ],
                ),

                child: Text(

                  affirmation,

                  textAlign: TextAlign.center,

                  style: const TextStyle(

                    fontSize: 20,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),

          const SizedBox(height: 15),

          // ================= GAME AREA =================

          Expanded(

            child: Container(

              margin:
              const EdgeInsets.all(16),

              decoration: BoxDecoration(

                gradient: LinearGradient(

                  colors: [

                    Colors.blue.shade50,

                    Colors.purple.shade50,
                  ],
                ),

                borderRadius:
                BorderRadius.circular(35),
              ),

              child: Stack(

                children: [

                  // ================= START BUTTON =================

                  if (!gameStarted)

                    Center(

                      child: ElevatedButton(

                        onPressed: startGame,

                        style:
                        ElevatedButton.styleFrom(

                          backgroundColor:
                          Colors.blue,

                          padding:
                          const EdgeInsets.symmetric(

                            horizontal: 45,

                            vertical: 18,
                          ),
                        ),

                        child: const Text(

                          "Start Healing 🌿",

                          style: TextStyle(

                            color: Colors.white,

                            fontSize: 22,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // ================= BUBBLES =================

                  ...bubbles.asMap().entries.map(

                        (entry) {

                      int index = entry.key;

                      StressBubble bubble =
                          entry.value;

                      return Positioned(

                        left:
                        bubble.x *
                            MediaQuery.of(context)
                                .size
                                .width *
                            0.75,

                        top:
                        bubble.y *
                            MediaQuery.of(context)
                                .size
                                .height *
                            0.55,

                        child: GestureDetector(

                          onTap: () {

                            popBubble(index);
                          },

                          child: AnimatedContainer(

                            duration:
                            const Duration(
                                milliseconds: 300),

                            width: bubble.size,

                            height: bubble.size,

                            decoration: BoxDecoration(

                              shape: BoxShape.circle,

                              gradient: LinearGradient(

                                colors: [

                                  bubble.color
                                      .withOpacity(
                                      0.7),

                                  bubble.color
                                      .withOpacity(
                                      0.4),
                                ],
                              ),

                              boxShadow: [

                                BoxShadow(

                                  color:
                                  bubble.color
                                      .withOpacity(
                                      0.35),

                                  blurRadius: 15,

                                  spreadRadius: 5,
                                ),
                              ],
                            ),

                            child: Center(

                              child: Padding(

                                padding:
                                const EdgeInsets.all(
                                    8),

                                child: Text(

                                  bubble.text,

                                  textAlign:
                                  TextAlign.center,

                                  style:
                                  const TextStyle(

                                    color:
                                    Colors.white,

                                    fontWeight:
                                    FontWeight.bold,

                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= INFO CARD =================

  Widget buildInfoCard(

      String title,
      String value,
      Color color,
      ) {

    return Container(

      padding:
      const EdgeInsets.symmetric(

        horizontal: 18,

        vertical: 14,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(

            color:
            Colors.black.withOpacity(
                0.05),

            blurRadius: 10,
          ),
        ],
      ),

      child: Column(

        children: [

          Text(

            title,

            style: const TextStyle(

              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 6),

          Text(

            value,

            style: TextStyle(

              color: color,

              fontSize: 22,

              fontWeight:
              FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= MODEL =================

class StressBubble {

  final double x;

  final double y;

  final double size;

  final Color color;

  final String text;

  StressBubble({

    required this.x,

    required this.y,

    required this.size,

    required this.color,

    required this.text,
  });
}