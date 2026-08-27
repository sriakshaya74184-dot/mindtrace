import 'dart:async';

import 'package:flutter/material.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() =>
      _MeditationScreenState();
}

class _MeditationScreenState
    extends State<MeditationScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  Timer? timer;

  bool isBreathing = false;

  String breathingText = "Relax";

  int selectedMinutes = 2;

  int remainingSeconds = 120;

  // ================= INIT =================

  @override
  void initState() {

    super.initState();

    controller = AnimationController(

      vsync: this,

      duration: const Duration(seconds: 4),

      lowerBound: 0.7,

      upperBound: 1.0,
    );

    controller.addStatusListener((status) {

      if (status ==
          AnimationStatus.forward) {

        setState(() {

          breathingText = "Inhale";
        });

      } else if (status ==
          AnimationStatus.reverse) {

        setState(() {

          breathingText = "Exhale";
        });
      }
    });
  }

  // ================= START SESSION =================

  void startBreathing() {

    controller.repeat(reverse: true);

    setState(() {

      isBreathing = true;
    });

    startTimer();
  }

  // ================= STOP SESSION =================

  void stopBreathing() {

    controller.stop();

    timer?.cancel();

    setState(() {

      isBreathing = false;

      breathingText = "Relax";

      remainingSeconds =
          selectedMinutes * 60;
    });
  }

  // ================= TIMER =================

  void startTimer() {

    remainingSeconds =
        selectedMinutes * 60;

    timer?.cancel();

    timer = Timer.periodic(

      const Duration(seconds: 1),

          (timer) {

        if (remainingSeconds > 0) {

          setState(() {

            remainingSeconds--;
          });

        } else {

          stopBreathing();

          ScaffoldMessenger.of(context)
              .showSnackBar(

            const SnackBar(

              content: Text(
                "Meditation Session Completed 🌿",
              ),
            ),
          );
        }
      },
    );
  }

  // ================= FORMAT TIME =================

  String formatTime(int seconds) {

    final minutes =
    (seconds ~/ 60)
        .toString()
        .padLeft(2, '0');

    final secs =
    (seconds % 60)
        .toString()
        .padLeft(2, '0');

    return "$minutes:$secs";
  }

  // ================= DISPOSE =================

  @override
  void dispose() {

    controller.dispose();

    timer?.cancel();

    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: BoxDecoration(

          gradient: LinearGradient(

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

            colors: [

              Colors.blue.shade100,

              Colors.purple.shade50,

              Colors.white,
            ],
          ),
        ),

        child: SafeArea(

          child: SingleChildScrollView(

            child: Padding(

              padding:
              const EdgeInsets.all(24),

              child: Column(

                children: [

                  // ================= HEADER =================

                  Row(

                    children: [

                      IconButton(

                        onPressed: () {

                          Navigator.pop(context);
                        },

                        icon: const Icon(
                          Icons.arrow_back_ios,
                        ),
                      ),

                      const Expanded(

                        child: Text(

                          "Meditation",

                          textAlign:
                          TextAlign.center,

                          style: TextStyle(
                            fontSize: 26,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(width: 40),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ================= QUOTE =================

                  Container(

                    width: double.infinity,

                    padding:
                    const EdgeInsets.all(20),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(24),

                      boxShadow: [

                        BoxShadow(

                          color:
                          Colors.black12,

                          blurRadius: 10,

                          offset:
                          const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: const Column(

                      children: [

                        Icon(
                          Icons.spa,
                          size: 42,
                          color: Colors.blue,
                        ),

                        SizedBox(height: 12),

                        Text(

                          "Take a deep breath and calm your mind 🌿",

                          textAlign:
                          TextAlign.center,

                          style: TextStyle(
                            fontSize: 18,
                            height: 1.5,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 45),

                  // ================= BREATHING CIRCLE =================

                  ScaleTransition(

                    scale: controller,

                    child: Container(

                      width: 240,
                      height: 240,

                      decoration: BoxDecoration(

                        shape: BoxShape.circle,

                        gradient: LinearGradient(

                          colors: [

                            Colors.blue.shade300,

                            Colors.purple.shade200,
                          ],
                        ),

                        boxShadow: [

                          BoxShadow(

                            color:
                            Colors.blue
                                .withOpacity(0.25),

                            blurRadius: 30,

                            spreadRadius: 10,
                          ),
                        ],
                      ),

                      child: Center(

                        child: Column(

                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [

                            Text(

                              breathingText,

                              style: const TextStyle(

                                fontSize: 32,

                                fontWeight:
                                FontWeight.bold,

                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(

                              formatTime(
                                  remainingSeconds),

                              style: const TextStyle(

                                fontSize: 26,

                                fontWeight:
                                FontWeight.bold,

                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // ================= TIMER SELECTION =================

                  const Align(

                    alignment:
                    Alignment.centerLeft,

                    child: Text(

                      "Choose Session",

                      style: TextStyle(

                        fontSize: 20,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  GridView.count(

                    shrinkWrap: true,

                    physics:
                    const NeverScrollableScrollPhysics(),

                    crossAxisCount: 2,

                    crossAxisSpacing: 15,

                    mainAxisSpacing: 15,

                    childAspectRatio: 2.2,

                    children: [

                      buildTimerCard(2),

                      buildTimerCard(5),

                      buildTimerCard(10),

                      buildTimerCard(20),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // ================= BUTTON =================

                  SizedBox(

                    width: double.infinity,

                    height: 58,

                    child: ElevatedButton(

                      onPressed: () {

                        if (isBreathing) {

                          stopBreathing();

                        } else {

                          startBreathing();
                        }
                      },

                      style:
                      ElevatedButton.styleFrom(

                        backgroundColor:
                        Colors.blue,

                        shape:
                        RoundedRectangleBorder(

                          borderRadius:
                          BorderRadius.circular(
                              18),
                        ),
                      ),

                      child: Text(

                        isBreathing
                            ? "Stop Session"
                            : "Start Meditation",

                        style: const TextStyle(

                          fontSize: 18,

                          color: Colors.white,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= TIMER CARD =================

  Widget buildTimerCard(int minutes) {

    final bool isSelected =
        selectedMinutes == minutes;

    return GestureDetector(

      onTap: () {

        setState(() {

          selectedMinutes = minutes;

          remainingSeconds =
              minutes * 60;
        });
      },

      child: Container(

        decoration: BoxDecoration(

          color: isSelected
              ? Colors.blue
              : Colors.white,

          borderRadius:
          BorderRadius.circular(20),

          boxShadow: [

            BoxShadow(

              color:
              Colors.black12,

              blurRadius: 8,

              offset:
              const Offset(0, 4),
            ),
          ],
        ),

        child: Center(

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              Icon(

                Icons.timer,

                color: isSelected
                    ? Colors.white
                    : Colors.blue,
              ),

              const SizedBox(height: 6),

              Text(

                "$minutes MIN",

                style: TextStyle(

                  fontSize: 18,

                  fontWeight:
                  FontWeight.bold,

                  color: isSelected
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}