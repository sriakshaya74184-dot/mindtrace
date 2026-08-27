import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {

  final IconData icon;
  final String title;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: () {

      },

      borderRadius:
      BorderRadius.circular(24),

      child: Container(

        decoration: BoxDecoration(

          color: Colors.white,

          borderRadius:
          BorderRadius.circular(24),

          boxShadow: [

            BoxShadow(
              color:
              Colors.black.withOpacity(0.04),

              blurRadius: 12,

              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,

          children: [

            Container(

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.blue.shade50,

                shape: BoxShape.circle,
              ),

              child: Icon(
                icon,
                size: 35,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              title,

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}