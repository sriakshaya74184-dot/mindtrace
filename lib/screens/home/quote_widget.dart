import 'dart:async';

import 'package:flutter/material.dart';

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({super.key});

  @override
  State<QuoteWidget> createState() =>
      _QuoteWidgetState();
}

class _QuoteWidgetState
    extends State<QuoteWidget> {

  final List<String> quotes = [

    "Take care of your mind 🧠",

    "Small progress is still progress 🌱",

    "Focus on yourself and grow ✨",

    "Every day is a fresh start ☀️",

    "Your mental health matters ❤️",
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(
      const Duration(seconds: 3),

          (timer) {
        setState(() {
          currentIndex =
              (currentIndex + 1) %
                  quotes.length;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return
      AnimatedContainer
        (

        duration
            :
        const
        Duration
          (
            milliseconds
                :
            500
        )
        ,

        width
            :
        double
            .
        infinity
        ,

        padding
            :
        const
        EdgeInsets
            .
        symmetric
          (
          horizontal
              :
          22
          ,
          vertical
              :
          18
          ,
        )
        ,

        decoration
            :
        BoxDecoration
          (

          gradient
              :
          LinearGradient
            (
            colors
                :
            [
              Colors
                  .
              blue
                  .
              shade100
              ,
              Colors
                  .
              purple
                  .
              shade100
              ,
            ]
            ,
          )
          ,

          borderRadius
              :
          BorderRadius
              .
          circular
            (
              22
          )
          ,
        )
        ,

        child
            :
        Row
          (

          children
              :
          [

            Icon
              (
              Icons
                  .
              auto_awesome
              ,
              color
                  :
              Colors
                  .
              blue
                  .
              shade700
              ,
            )
            ,

            const
            SizedBox
              (
                width
                    :
                12
            )
            ,

            Expanded
              (
              child
                  :
              Text
                (

                quotes
                [
                currentIndex
                ]
                ,

                style
                    :
                const
                TextStyle
                  (
                  fontSize
                      :
                  16
                  ,
                  fontWeight
                      :
                  FontWeight
                      .
                  w600
                  ,
                )
                ,
              )
              ,
            )
            ,
          ]
          ,
        )
        ,
      );
  }
}