import 'dart:async';

import 'package:flutter/material.dart';

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {

  int seconds = 1500;

  Timer? timer;

  bool isRunning = false;

  void startTimer() {

    timer = Timer.periodic(
      const Duration(seconds: 1),

          (timer) {

        if (seconds > 0) {

          setState(() {
            seconds--;
          });

        } else {

          timer.cancel();

          setState(() {
            isRunning = false;
          });
        }
      },
    );

    setState(() {
      isRunning = true;
    });
  }

  void pauseTimer() {

    timer?.cancel();

    setState(() {
      isRunning = false;
    });
  }

  void resetTimer() {

    timer?.cancel();

    setState(() {

      seconds = 1500;

      isRunning = false;

    });
  }

  String formatTime(int totalSeconds) {

    int minutes = totalSeconds ~/ 60;

    int remainingSeconds = totalSeconds % 60;

    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Focus Mode"),
        centerTitle: true,
      ),

      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const Text(
              "Pomodoro Timer",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            Container(

              padding: const EdgeInsets.all(40),

              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.shade50,
              ),

              child: Text(
                formatTime(seconds),

                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 50),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                ElevatedButton(

                  onPressed: isRunning
                      ? null
                      : startTimer,

                  child: const Text("Start"),
                ),

                const SizedBox(width: 20),

                ElevatedButton(

                  onPressed: isRunning
                      ? pauseTimer
                      : null,

                  child: const Text("Pause"),
                ),

                const SizedBox(width: 20),

                ElevatedButton(

                  onPressed: resetTimer,

                  child: const Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}