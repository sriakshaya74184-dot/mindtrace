import 'package:flutter/material.dart';

class ThoughtSortingGame extends StatefulWidget {
  const ThoughtSortingGame({super.key});

  @override
  State<ThoughtSortingGame> createState() =>
      _ThoughtSortingGameState();
}

class _ThoughtSortingGameState
    extends State<ThoughtSortingGame> {

  final List<Map<String, dynamic>> thoughts = [
    {
      "text": "I can improve with practice.",
      "keep": true,
      "explanation": "Growth comes from practice and learning."
    },
    {
      "text": "I always fail.",
      "keep": false,
      "explanation": "This thought is overly negative and should be released."
    },
    {
      "text": "Small steps matter.",
      "keep": true,
      "explanation": "Progress happens one step at a time."
    },
    {
      "text": "Nobody likes me.",
      "keep": false,
      "explanation": "This is an assumption, not a fact."
    },
    {
      "text": "Mistakes help me learn.",
      "keep": true,
      "explanation": "Mistakes are opportunities for growth."
    },
    {
      "text": "Nothing will get better.",
      "keep": false,
      "explanation": "This thought removes hope and should be released."
    },
    {
      "text": "I am growing every day.",
      "keep": true,
      "explanation": "Growth is a healthy mindset."
    },
    {
      "text": "I am not good enough.",
      "keep": false,
      "explanation": "This thought is self-critical and unhelpful."
    },
  ];

  int currentIndex = 0;
  int progress = 0;
  List<String> keptThoughts = [];
  List<String> releasedThoughts = [];
  void sortThought(bool keepChoice) {

    final currentThought = thoughts[currentIndex];

    bool correctChoice =
        keepChoice == currentThought["keep"];

    if (!correctChoice) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          backgroundColor: Colors.orange,

          content: Text(
            "💡 Think Again\n${currentThought["explanation"]}",
          ),
        ),
      );

      return;
    }

    if (keepChoice) {

      keptThoughts.add(
        currentThought["text"],
      );

    } else {

      releasedThoughts.add(
        currentThought["text"],
      );
    }
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        backgroundColor: Colors.green,

        content: Text(
          "✅ Great Choice",
        ),
      ),
    );

    setState(() {

      currentIndex++;
      progress++;
    });

    if (currentIndex >= thoughts.length) {

      Future.delayed(
        const Duration(milliseconds: 500),
            () {
          showCompletionDialog();
        },
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
            "🌱 Your Reflection",
          ),

          content: SingleChildScrollView(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              mainAxisSize: MainAxisSize.min,

              children: [

                const Text(

                  "🍂 Thoughts Released",

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                ...releasedThoughts.map(

                      (thought) => Padding(

                    padding:
                    const EdgeInsets.only(
                        bottom: 4),

                    child: Text(
                      "✓ $thought",
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Text(

                  "🌿 Thoughts Kept",

                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                ...keptThoughts.map(

                      (thought) => Padding(

                    padding:
                    const EdgeInsets.only(
                        bottom: 4),

                    child: Text(
                      "✓ $thought",
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(

                  "Growth starts with recognizing which thoughts help you and which ones hold you back.",

                  style: TextStyle(
                    fontStyle: FontStyle.italic,
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

    return Scaffold(

      backgroundColor:
      const Color(0xFFF5F7FA),

      appBar: AppBar(

        backgroundColor: Colors.white,

        elevation: 0,

        centerTitle: true,

        title: const Text(

          "🌱 Thought Sorting",

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

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 10),

            LinearProgressIndicator(

              value:
              progress / thoughts.length,

              minHeight: 10,

              borderRadius:
              BorderRadius.circular(20),
            ),

            const SizedBox(height: 12),

            Text(

              "$progress / ${thoughts.length} Completed",

              style: const TextStyle(

                fontWeight:
                FontWeight.bold,

                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            Expanded(

              child: Center(

                child: AnimatedContainer(

                  duration:
                  const Duration(
                      milliseconds: 300),

                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(28),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                    BorderRadius.circular(25),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black
                            .withOpacity(0.05),

                        blurRadius: 15,

                        offset:
                        const Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Center(

                    child: Text(

                      currentIndex <
                          thoughts.length

                          ? thoughts[currentIndex]
                      ["text"]

                          : "Completed",

                      textAlign:
                      TextAlign.center,

                      style:
                      const TextStyle(

                        fontSize: 24,

                        fontWeight:
                        FontWeight.w600,

                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Row(

              children: [

                Expanded(

                  child: ElevatedButton.icon(

                    onPressed: () {

                      sortThought(false);
                    },

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      Colors.orange.shade200,

                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 16,
                      ),

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(
                            18),
                      ),
                    ),

                    icon: const Text(
                      "🍂",
                      style: TextStyle(
                          fontSize: 20),
                    ),

                    label: const Text(

                      "Release Thought",

                      style: TextStyle(

                        fontSize: 18,

                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(

                  child: ElevatedButton.icon(

                    onPressed: () {

                      sortThought(true);
                    },

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      Colors.green.shade300,

                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 16,
                      ),

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(
                            18),
                      ),
                    ),

                    icon: const Text(
                      "🌿",
                      style: TextStyle(
                          fontSize: 20),
                    ),

                    label: const Text(

                      "Keep Growing",

                      style: TextStyle(

                        fontSize: 18,

                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}