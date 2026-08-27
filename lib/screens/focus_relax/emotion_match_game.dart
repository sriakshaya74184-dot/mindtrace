import 'package:flutter/material.dart';

class EmotionMatchGame extends StatefulWidget {
  const EmotionMatchGame({super.key});

  @override
  State<EmotionMatchGame> createState() =>
      _EmotionMatchGameState();
}

class _EmotionMatchGameState
    extends State<EmotionMatchGame> {

  final Map<String, String> pairs = {

    "Stress": "Breathing",
    "Fear": "Courage",
    "Sadness": "Hope",
    "Pressure": "Balance",
    "Anger": "Patience",
    "Worry": "Mindfulness",
    "Doubt": "Confidence",
    "Loneliness": "Connection",
  };

  String? selectedEmotion;

  int matchesMade = 0;

  List<String> completedEmotions = [];

  List<String> completedMatches = [];

  late List<String> emotions;
  late List<String> responses;

  @override
  void initState() {
    super.initState();

    emotions = pairs.keys.toList();

    responses = pairs.values.toList()
      ..shuffle();
  }

  void checkMatch(String response) {

    if (selectedEmotion == null) return;

    bool correct =
        pairs[selectedEmotion] == response;

    ScaffoldMessenger.of(context)
        .clearSnackBars();

    if (correct) {

      setState(() {

        completedMatches.add(
          "$selectedEmotion → $response",
        );

        completedEmotions.add(
          selectedEmotion!,
        );

        matchesMade++;

        responses.remove(response);

        selectedEmotion = null;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          backgroundColor:
          Colors.green,

          content: Text(
            "✅ Great Match",
          ),
        ),
      );

      if (matchesMade == pairs.length) {

        Future.delayed(
          const Duration(
              milliseconds: 500),
              () {
            showCompletionDialog();
          },
        );
      }

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          backgroundColor:
          Colors.orange,

          content: Text(
            "💡 Try Again",
          ),
        ),
      );
    }
  }

  void showCompletionDialog() {

    showDialog(

      context: context,

      barrierDismissible: false,

      builder: (context) {

        return AlertDialog(

          shape: RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(20),
          ),

          title: const Text(
            "💙 Emotion Match Complete",
          ),

          content:
          SingleChildScrollView(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              mainAxisSize:
              MainAxisSize.min,

              children: [

                const Text(

                  "Matches Made",

                  style: TextStyle(

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ...completedMatches.map(

                      (match) => Padding(

                    padding:
                    const EdgeInsets.only(
                        bottom: 6),

                    child: Text(
                      "✓ $match",
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(

                  "Understanding emotions helps you respond in healthier ways.",

                  style: TextStyle(
                    fontStyle:
                    FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {

                setState(() {

                  matchesMade = 0;

                  completedEmotions.clear();

                  completedMatches.clear();

                  selectedEmotion = null;

                  emotions =
                      pairs.keys.toList();

                  responses =
                  pairs.values.toList()
                    ..shuffle();
                });

                Navigator.pop(context);
              },

              child: const Text(
                "Play Again",
              ),
            ),

            ElevatedButton(

              onPressed: () {

                Navigator.pop(context);
                Navigator.pop(context);
              },

              child: const Text(
                "Close",
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF5F7FA),

      appBar: AppBar(

        backgroundColor:
        Colors.white,

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "💙 Emotion Match",

          style: TextStyle(
            color: Colors.black,
          ),
        ),

        actions: [

          IconButton(

            onPressed: () {

              ScaffoldMessenger.of(context)
                  .clearSnackBars();

              Navigator.pop(context);
            },

            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
        ],
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            LinearProgressIndicator(

              value:
              matchesMade / pairs.length,

              minHeight: 10,

              borderRadius:
              BorderRadius.circular(20),
            ),

            const SizedBox(height: 10),

            Text(

              "$matchesMade / ${pairs.length} Matched",

              style: const TextStyle(

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 25),

            Expanded(

              child: Row(

                children: [

                  /// LEFT SIDE
                  Expanded(

                    child: Column(

                      children: [

                        const Text(

                          "Emotions",

                          style: TextStyle(

                            fontWeight:
                            FontWeight.bold,

                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Expanded(

                          child: ListView(

                            children:

                            emotions.map((emotion) {

                              bool done =
                              completedEmotions
                                  .contains(
                                  emotion);

                              if (done) {
                                return const SizedBox();
                              }

                              return Padding(

                                padding:
                                const EdgeInsets.only(
                                    bottom: 10),

                                child:
                                ElevatedButton(

                                  onPressed: () {

                                    setState(() {

                                      selectedEmotion =
                                          emotion;
                                    });
                                  },

                                  style:
                                  ElevatedButton.styleFrom(

                                    backgroundColor:

                                    selectedEmotion ==
                                        emotion

                                        ? Colors.blue.shade100

                                        : Colors.white,

                                    foregroundColor:
                                    Colors.black,

                                    padding:
                                    const EdgeInsets.all(
                                        15),
                                  ),

                                  child: Text(
                                    emotion,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 15),

                  /// RIGHT SIDE
                  Expanded(

                    child: Column(

                      children: [

                        const Text(

                          "Responses",

                          style: TextStyle(

                            fontWeight:
                            FontWeight.bold,

                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Expanded(

                          child: ListView(

                            children:

                            responses.map((response) {

                              return Padding(

                                padding:
                                const EdgeInsets.only(
                                    bottom: 10),

                                child:
                                ElevatedButton(

                                  onPressed: () {

                                    checkMatch(
                                        response);
                                  },

                                  style:
                                  ElevatedButton.styleFrom(

                                    backgroundColor:
                                    Colors.white,

                                    foregroundColor:
                                    Colors.black,

                                    padding:
                                    const EdgeInsets.all(
                                        15),
                                  ),

                                  child: Text(
                                    response,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
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