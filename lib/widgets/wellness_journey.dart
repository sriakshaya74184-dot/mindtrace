import 'package:flutter/material.dart';

class WellnessJourney extends StatelessWidget {
  const WellnessJourney({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(

        gradient: LinearGradient(
          colors: [
            Colors.blue.shade50,
            Colors.purple.shade50,
          ],
        ),

        borderRadius:
        BorderRadius.circular(28),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const Row(

            children: [

              Icon(
                Icons.favorite,
                color: Colors.pink,
                size: 28,
              ),

              SizedBox(width: 12),

              Text(
                "Your Wellness Journey",

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          buildStep(
            Icons.mood,
            "Track your mood daily",
          ),

          buildStep(
            Icons.favorite,
            "Complete healthy habits",
          ),

          buildStep(
            Icons.menu_book,
            "Write memory journals",
          ),

          buildStep(
            Icons.self_improvement,
            "Practice meditation",
          ),

          buildStep(
            Icons.timer,
            "Improve focus using Pomodoro",
          ),

          const SizedBox(height: 25),

          Container(

            padding: const EdgeInsets.all(18),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(20),
            ),

            child: const Row(

              children: [

                Icon(
                  Icons.lightbulb,
                  color: Colors.orange,
                ),

                SizedBox(width: 12),

                Expanded(

                  child: Text(

                    "Small daily improvements lead to long-term mental wellness 🌿",

                    style: TextStyle(
                      height: 1.5,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStep(
      IconData icon,
      String title,
      ) {

    return Padding(

      padding:
      const EdgeInsets.only(bottom: 18),

      child: Row(

        children: [

          Container(

            padding:
            const EdgeInsets.all(14),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(

            child: Text(

              title,

              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}