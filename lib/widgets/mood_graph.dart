import 'package:flutter/material.dart';

class MoodGraph extends StatelessWidget {
  const MoodGraph({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              const Icon(
                Icons.bar_chart,
                color: Colors.blue,
              ),

              const SizedBox(width: 10),

              const Text(
                "Weekly Mood Analysis",

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Row(

            mainAxisAlignment:
            MainAxisAlignment.spaceAround,

            crossAxisAlignment:
            CrossAxisAlignment.end,

            children: [

              buildBar("Mon", 70),
              buildBar("Tue", 90),
              buildBar("Wed", 50),
              buildBar("Thu", 80),
              buildBar("Fri", 60),
              buildBar("Sat", 100),
              buildBar("Sun", 75),
            ],
          ),

          const SizedBox(height: 20),

          const Center(
            child: Text(
              "Your mood improved this week 🌿",

              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBar(
      String day,
      double height,
      ) {

    return Column(

      children: [

        Container(

          width: 22,

          height: height,

          decoration: BoxDecoration(

            gradient: LinearGradient(
              colors: [
                Colors.blue.shade300,
                Colors.purple.shade300,
              ],
            ),

            borderRadius:
            BorderRadius.circular(12),
          ),
        ),

        const SizedBox(height: 8),

        Text(day),
      ],
    );
  }
}