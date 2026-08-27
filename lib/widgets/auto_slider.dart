import 'dart:async';

import 'package:flutter/material.dart';

class AutoSlider extends StatefulWidget {
  const AutoSlider({super.key});

  @override
  State<AutoSlider> createState() =>
      _AutoSliderState();
}

class _AutoSliderState
    extends State<AutoSlider> {

  final PageController _controller =
  PageController();

  int currentPage = 0;

  final List<Map<String, String>> quotes = [

    {
      "emoji": "✨",
      "text": "Your mental health matters ❤️",
    },

    {
      "emoji": "🌿",
      "text": "Take a deep breath and relax",
    },

    {
      "emoji": "💙",
      "text": "MindTrace is here for you",
    },

    {
      "emoji": "🌸",
      "text": "Small progress is still progress",
    },
  ];

  Timer? timer;

  @override
  void initState() {

    super.initState();

    startSlider();
  }

  // ================= AUTO SLIDER =================

  void startSlider() {

    timer = Timer.periodic(
      const Duration(seconds: 3),
          (timer) {

        if (currentPage <
            quotes.length - 1) {

          currentPage++;

        } else {

          currentPage = 0;
        }

        _controller.animateToPage(

          currentPage,

          duration:
          const Duration(milliseconds: 500),

          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {

    timer?.cancel();

    _controller.dispose();

    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        SizedBox(

          height: 90,

          child: PageView.builder(

            controller: _controller,

            itemCount: quotes.length,

            itemBuilder: (context, index) {

              return Container(

                margin:
                const EdgeInsets.symmetric(
                  horizontal: 4,
                ),

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                decoration: BoxDecoration(

                  gradient: LinearGradient(

                    colors: [

                      Colors.blue.shade200,

                      Colors.purple.shade200,
                    ],
                  ),

                  borderRadius:
                  BorderRadius.circular(24),
                ),

                child: Row(

                  children: [

                    Text(
                      quotes[index]["emoji"]!,
                      style: const TextStyle(
                        fontSize: 26,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(

                      child: Text(

                        quotes[index]["text"]!,

                        style: const TextStyle(

                          fontSize: 18,

                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // ================= DOT INDICATOR =================

        Row(

          mainAxisAlignment:
          MainAxisAlignment.center,

          children: List.generate(

            quotes.length,

                (index) {

              return Container(

                margin:
                const EdgeInsets.symmetric(
                  horizontal: 4,
                ),

                width:
                currentPage == index
                    ? 18
                    : 8,

                height: 8,

                decoration: BoxDecoration(

                  color:
                  currentPage == index
                      ? Colors.blue
                      : Colors.grey.shade400,

                  borderRadius:
                  BorderRadius.circular(20),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}