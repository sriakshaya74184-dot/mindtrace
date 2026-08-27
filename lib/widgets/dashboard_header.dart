import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {

  final String username;

  const DashboardHeader({
    super.key,
    required this.username,
  });

  String getGreeting() {

    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Ready for a fresh start today?";
    }

    if (hour < 17) {
      return "Stay focused and keep moving!";
    }

    if (hour < 21) {
      return "You are doing great today.";
    }

    return "Take a moment to relax and recharge.";
  }

  @override
  Widget build(BuildContext context) {

    return Container(

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(

        gradient: LinearGradient(
          colors: [
            Colors.blue.shade200,
            Colors.purple.shade200,
          ],
        ),

        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // ================= POSITIVE TAG =================

          Align(

            alignment: Alignment.topRight,

            child: Container(

              padding:
              const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(18),
              ),

              child: const Row(

                mainAxisSize: MainAxisSize.min,

                children: [

                  Icon(
                    Icons.auto_awesome,
                    color: Colors.orange,
                    size: 18,
                  ),

                  SizedBox(width: 8),

                  Text(
                    "Stay Positive",
                    style: TextStyle(
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 25),

          // ================= GREETING =================

          Text(

            getGreeting(),

            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          // ================= USER NAME =================

          Text(

            username.isEmpty
                ? "MindTrace User"
                : username,

            overflow: TextOverflow.ellipsis,

            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          // ================= MOTIVATION =================

          const Text(

            "Take care of your wellness today 🌿",

            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}