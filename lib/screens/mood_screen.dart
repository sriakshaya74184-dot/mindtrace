import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() =>
      _MoodScreenState();
}

class _MoodScreenState
    extends State<MoodScreen> {

  String selectedMood = "";

  String moodQuote = "";

  bool alreadySavedToday = false;

  String todayMood = "";

  // ================= MOOD LIST =================

  final List<Map<String, dynamic>> moods = [

    {
      "emoji": "😄",
      "text": "Happy",
      "color": Colors.orange,
    },

    {
      "emoji": "😍",
      "text": "Excited",
      "color": Colors.pink,
    },

    {
      "emoji": "🙂",
      "text": "Good",
      "color": Colors.green,
    },

    {
      "emoji": "😌",
      "text": "Calm",
      "color": Colors.teal,
    },

    {
      "emoji": "😐",
      "text": "Normal",
      "color": Colors.amber,
    },

    {
      "emoji": "😔",
      "text": "Sad",
      "color": Colors.blueGrey,
    },

    {
      "emoji": "😡",
      "text": "Angry",
      "color": Colors.red,
    },

    {
      "emoji": "😩",
      "text": "Stressed",
      "color": Colors.deepPurple,
    },
  ];

  // ================= QUOTES =================

  final Map<String, String> quotes = {

    "Happy":
    "Keep spreading your positive energy ✨",

    "Excited":
    "Your excitement can create beautiful things 🚀",

    "Good":
    "Small progress is still progress 🌱",

    "Calm":
    "Peace begins with a deep breath 🌿",

    "Normal":
    "Every day doesn’t need to be perfect ☀️",

    "Sad":
    "Tough days don’t last forever ❤️",

    "Angry":
    "Pause. Breathe. Let calmness guide you 🌊",

    "Stressed":
    "You are stronger than your stress 💪",
  };

  // ================= INIT =================

  @override
  void initState() {

    super.initState();

    loadMoodData();
  }

  // ================= LOAD SAVED DATA =================

  Future<void> loadMoodData() async {

    final prefs =
    await SharedPreferences.getInstance();

    final savedDate =
    prefs.getString('mood_date');

    final savedMood =
    prefs.getString('mood_value');

    final today =
    DateTime.now().toString().split(' ')[0];

    if (savedDate == today &&
        savedMood != null) {

      setState(() {

        alreadySavedToday = true;

        todayMood = savedMood;

        moodQuote =
            quotes[savedMood] ?? "";
      });
    }
  }

  // ================= SAVE MOOD =================

  Future<void> saveMood() async {

    if (alreadySavedToday) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            "You already tracked today's mood 🌿",
          ),
        ),
      );

      return;
    }

    if (selectedMood.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
          Text("Please select your mood"),
        ),
      );

      return;
    }

    final prefs =
    await SharedPreferences.getInstance();

    final today =
    DateTime.now().toString().split(' ')[0];

    await prefs.setString(
      'mood_date',
      today,
    );

    await prefs.setString(
      'mood_value',
      selectedMood,
    );

    setState(() {

      alreadySavedToday = true;

      todayMood = selectedMood;

      moodQuote =
          quotes[selectedMood] ?? "";
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        behavior:
        SnackBarBehavior.floating,

        content: Text(
          "Mood Saved: $selectedMood",
        ),
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
          "Mood Tracker",
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const Text(

              "How are you feeling today?",

              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(

              "Track your emotions and improve your wellness journey.",

              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
            ),

            const SizedBox(height: 30),

            // ================= STATUS =================

            if (alreadySavedToday)

              Container(

                width: double.infinity,

                padding:
                const EdgeInsets.all(18),

                decoration: BoxDecoration(

                  color: Colors.green.shade50,

                  borderRadius:
                  BorderRadius.circular(20),

                  border: Border.all(
                    color: Colors.green.shade200,
                  ),
                ),

                child: Row(

                  children: [

                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),

                    const SizedBox(width: 12),

                    Expanded(

                      child: Text(

                        "Today's mood already tracked: $todayMood 🌿",

                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            if (alreadySavedToday)
              const SizedBox(height: 25),

            // ================= MOODS =================

            GridView.builder(

              shrinkWrap: true,

              physics:
              const NeverScrollableScrollPhysics(),

              itemCount: moods.length,

              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: 15,

                mainAxisSpacing: 15,
              ),

              itemBuilder: (context, index) {

                final mood = moods[index];

                final bool isSelected =
                    selectedMood ==
                        mood["text"];

                return GestureDetector(

                  onTap: alreadySavedToday
                      ? null
                      : () {

                    setState(() {

                      selectedMood =
                      mood["text"];
                    });
                  },

                  child: AnimatedContainer(

                    duration:
                    const Duration(
                        milliseconds: 300),

                    decoration: BoxDecoration(

                      gradient: isSelected

                          ? LinearGradient(
                        colors: [

                          mood["color"]
                              .withOpacity(0.25),

                          Colors.white,
                        ],
                      )

                          : null,

                      color: isSelected
                          ? null
                          : Colors.white,

                      borderRadius:
                      BorderRadius.circular(24),

                      border: Border.all(

                        color: isSelected
                            ? mood["color"]
                            : Colors.grey.shade200,

                        width: 2,
                      ),
                    ),

                    child: Column(

                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Text(
                          mood["emoji"],

                          style: const TextStyle(
                            fontSize: 52,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(

                          mood["text"],

                          style: const TextStyle(

                            fontSize: 18,

                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 35),

            // ================= BUTTON =================

            SizedBox(

              width: double.infinity,

              height: 58,

              child: ElevatedButton(

                onPressed:
                alreadySavedToday
                    ? null
                    : saveMood,

                child: Text(

                  alreadySavedToday
                      ? "Mood Already Tracked"
                      : "Save Mood",

                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // ================= QUOTE =================

            if (moodQuote.isNotEmpty)

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

                    const Row(

                      children: [

                        Icon(
                          Icons.auto_awesome,
                          color: Colors.blue,
                        ),

                        SizedBox(width: 10),

                        Text(

                          "Mood Insight",

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Text(

                      moodQuote,

                      style: TextStyle(

                        fontSize: 16,

                        height: 1.6,
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