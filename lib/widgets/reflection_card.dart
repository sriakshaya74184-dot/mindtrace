import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/reflections/reflection_history_screen.dart';
class ReflectionCard extends StatefulWidget {
  const ReflectionCard({super.key});

  @override
  State<ReflectionCard> createState() =>
      _ReflectionCardState();
}

class _ReflectionCardState
    extends State<ReflectionCard> {

  final TextEditingController
  reflectionController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    loadReflection();
  }

  Future<void> loadReflection() async {

    final prefs =
    await SharedPreferences.getInstance();

    String savedReflection =
        prefs.getString(
          "daily_reflection",
        ) ??
            "";

    reflectionController.text =
        savedReflection;
  }

  Future<void> saveReflection() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      "daily_reflection",
      reflectionController.text,
    );
    int count =
        prefs.getInt("reflection_count") ?? 0;

    await prefs.setInt(
      "reflection_count",
      count + 1,
    );
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content:
        Text("Reflection Saved"),

        duration:
        Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      padding:
      const EdgeInsets.all(22),

      decoration: BoxDecoration(

        gradient: LinearGradient(

          colors: [

            Colors.orange.shade50,
            Colors.pink.shade50,
          ],
        ),

        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              const Icon(

                Icons.auto_awesome,

                color: Colors.orange,
              ),

              const SizedBox(width: 10),

              const Text(

                "Voice of the Day",

                style: TextStyle(

                  fontSize: 22,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(

            "\"What made you smile today?\"",

            style: TextStyle(

              fontSize: 18,

              fontStyle:
              FontStyle.italic,

              height: 1.5,
            ),
          ),

          const SizedBox(height: 20),

          TextField(

            controller:
            reflectionController,

            maxLines: 4,

            decoration:
            InputDecoration(

              hintText:
              "Write your thoughts here...",

              filled: true,

              fillColor:
              Colors.white,

              border:
              OutlineInputBorder(

                borderRadius:
                BorderRadius.circular(
                    18),

                borderSide:
                BorderSide.none,
              ),

              contentPadding:
              const EdgeInsets.all(
                  18),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(

            width: double.infinity,

            child: ElevatedButton(

              onPressed:
              saveReflection,

              style:
              ElevatedButton.styleFrom(

                backgroundColor:
                Colors.blue.shade700,

                padding:
                const EdgeInsets
                    .symmetric(
                  vertical: 15,
                ),

                shape:
                RoundedRectangleBorder(

                  borderRadius:
                  BorderRadius.circular(
                      18),
                ),
              ),

              child: const Text(

                "Save Reflection",

                style: TextStyle(

                  fontSize: 16,

                  color: Colors.white,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(

            width: double.infinity,

            child: OutlinedButton(

              onPressed: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                    const ReflectionHistoryScreen(),
                  ),
                );
              },

              child: const Text(
                "View My Reflections",
              ),
            ),
          ),
        ],
      ),
    );
  }
}