import 'package:flutter/material.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(

        gradient: LinearGradient(
          colors: [
            Colors.purple.shade50,
            Colors.blue.shade50,
          ],
        ),

        borderRadius:
        BorderRadius.circular(28),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              Container(

                padding:
                const EdgeInsets.all(12),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(18),
                ),

                child: Icon(
                  Icons.psychology,
                  color: Colors.blue.shade700,
                  size: 32,
                ),
              ),

              const SizedBox(width: 15),

              const Expanded(

                child: Text(
                  "About MindTrace",

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          const Text(

            "MindTrace is a smart mental wellness app designed to help users build a healthier lifestyle through mood tracking, meditation, focus activities, journaling, and wellness insights.",

            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Colors.black87,
            ),
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
                  Icons.favorite,
                  color: Colors.red,
                ),

                SizedBox(width: 12),

                Expanded(

                  child: Text(

                    "Your mental wellness matters every single day ❤️",

                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(

            mainAxisAlignment:
            MainAxisAlignment.spaceAround,

            children: [

              buildInfo(
                Icons.mood,
                "Mood",
              ),

              buildInfo(
                Icons.menu_book,
                "Journal",
              ),

              buildInfo(
                Icons.self_improvement,
                "Meditate",
              ),

              buildInfo(
                Icons.timer,
                "Focus",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfo(
      IconData icon,
      String title,
      ) {

    return Column(

      children: [

        CircleAvatar(

          radius: 24,

          backgroundColor:
          Colors.white,

          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          title,

          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}