import 'package:flutter/material.dart';

class OppositeThoughtChallenge extends StatefulWidget {
  const OppositeThoughtChallenge({super.key});

  @override
  State<OppositeThoughtChallenge> createState() =>
      _OppositeThoughtChallengeState();
}

class _OppositeThoughtChallengeState
    extends State<OppositeThoughtChallenge> {

  final List<Map<String, dynamic>> questions = [

    {
      "negative": "I always fail.",
      "options": [
        "Give up",
        "I can learn from mistakes",
        "Avoid trying",
        "Compare myself to others",
      ],
      "correct":
      "I can learn from mistakes",
      "explanation":
      "Mistakes are opportunities to learn and grow."
    },

    {
      "negative": "Nobody likes me.",
      "options": [
        "Everyone hates me",
        "I am unworthy",
        "I cannot know what everyone thinks",
        "Stop talking to people",
      ],
      "correct":
      "I cannot know what everyone thinks",
      "explanation":
      "We often assume things without evidence."
    },

    {
      "negative": "I am not good enough.",
      "options": [
        "Hide from challenges",
        "Quit everything",
        "I am still growing",
        "Compare myself constantly",
      ],
      "correct":
      "I am still growing",
      "explanation":
      "Growth takes time and effort."
    },

    {
      "negative": "Nothing will get better.",
      "options": [
        "There is always hope for change",
        "Give up now",
        "Stay negative",
        "Avoid all effort",
      ],
      "correct":
      "There is always hope for change",
      "explanation":
      "Situations can improve with time and action."
    },

    {
      "negative": "I can't do this.",
      "options": [
        "I can try step by step",
        "Stop immediately",
        "I am helpless",
        "Avoid learning",
      ],
      "correct":
      "I can try step by step",
      "explanation":
      "Breaking tasks into steps makes them manageable."
    },

    {
      "negative": "Everyone is better than me.",
      "options": [
        "I should compare constantly",
        "Everyone is perfect",
        "My journey is unique",
        "Quit trying",
      ],
      "correct":
      "My journey is unique",
      "explanation":
      "Comparing yourself to others isn't helpful."
    },

    {
      "negative": "I made a mistake.",
      "options": [
        "Mistakes help me improve",
        "I am a failure",
        "Never try again",
        "Avoid responsibility",
      ],
      "correct":
      "Mistakes help me improve",
      "explanation":
      "Mistakes are part of learning."
    },

    {
      "negative": "Things are too hard.",
      "options": [
        "Small progress still counts",
        "Give up",
        "Do nothing",
        "Stay frustrated",
      ],
      "correct":
      "Small progress still counts",
      "explanation":
      "Progress matters more than perfection."
    },
  ];

  int currentIndex = 0;

  List<String> positiveChoices = [];

  void checkAnswer(String selected) {

    final current =
    questions[currentIndex];

    bool correct =
        selected == current["correct"];

    if (!correct) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          backgroundColor:
          Colors.orange,

          content: Text(
            "💡 Try Again\nChoose the thought that supports growth.",
          ),
        ),
      );

      return;
    }

    positiveChoices.add(
      current["correct"],
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        backgroundColor:
        Colors.green,

        content: Text(
          "✅ Great Choice\n${current["explanation"]}",
        ),
      ),
    );

    if (currentIndex ==
        questions.length - 1) {

      Future.delayed(

        const Duration(
            milliseconds: 600),

            () {

          showCompletionDialog();
        },
      );

    } else {

      setState(() {

        currentIndex++;
      });
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
            "🧠 Challenge Complete",
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

                  "Positive Choices Made",

                  style: TextStyle(

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...positiveChoices.map(

                      (choice) => Padding(

                    padding:
                    const EdgeInsets.only(
                        bottom: 6),

                    child: Text(
                      "✓ $choice",
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(

                  "You practiced replacing negative thoughts with healthier perspectives.",

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

                ScaffoldMessenger.of(context)
                    .clearSnackBars();

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

    final current =
    questions[currentIndex];

    return Scaffold(

      backgroundColor:
      const Color(0xFFF5F7FA),

      appBar: AppBar(

        backgroundColor:
        Colors.white,

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "🧠 Opposite Thought Challenge",

          style: TextStyle(
            color: Colors.black,
          ),
        ),

        actions: [

          IconButton(

            onPressed: () {

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
              (currentIndex + 1) /
                  questions.length,

              minHeight: 10,

              borderRadius:
              BorderRadius.circular(20),
            ),

            const SizedBox(height: 10),

            Text(

              "${currentIndex + 1} / ${questions.length}",

              style: const TextStyle(

                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Container(

              width: double.infinity,

              padding:
              const EdgeInsets.all(25),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(0.05),

                    blurRadius: 10,
                  ),
                ],
              ),

              child: Column(

                children: [

                  const Text(

                    "Replace This Thought",

                    style: TextStyle(

                      fontWeight:
                      FontWeight.bold,

                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(

                    current["negative"],

                    textAlign:
                    TextAlign.center,

                    style:
                    const TextStyle(

                      fontSize: 24,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            Expanded(

              child: ListView.builder(

                itemCount:
                current["options"].length,

                itemBuilder:
                    (context, index) {

                  final option =
                  current["options"]
                  [index];

                  return Padding(

                    padding:
                    const EdgeInsets.only(
                        bottom: 12),

                    child:
                    ElevatedButton(

                      onPressed: () {

                        checkAnswer(
                            option);
                      },

                      style:
                      ElevatedButton.styleFrom(

                        backgroundColor:
                        Colors.white,

                        foregroundColor:
                        Colors.black,

                        elevation: 2,

                        padding:
                        const EdgeInsets
                            .all(18),

                        shape:
                        RoundedRectangleBorder(

                          borderRadius:
                          BorderRadius
                              .circular(
                              15),
                        ),
                      ),

                      child: Text(

                        option,

                        style:
                        const TextStyle(

                          fontSize: 16,
                        ),
                      ),
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