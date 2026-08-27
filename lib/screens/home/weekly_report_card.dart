import 'package:flutter/material.dart';

class WeeklyReportCard extends StatelessWidget {
  const WeeklyReportCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(

        gradient: LinearGradient(
          colors: [
            Colors.blue.shade400,
            Colors.blue.shade700,
          ],
        ),

        borderRadius:
        BorderRadius.circular(25),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          const Text(
            "Weekly Wellness Report",

            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              buildReportItem(
                "Mood",
                "85%",
              ),

              buildReportItem(
                "Habits",
                "72%",
              ),

              buildReportItem(
                "Focus",
                "90%",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildReportItem(
      String title,
      String value,
      ) {

    return Column(

      children: [

        Text(
          value,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          title,

          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}