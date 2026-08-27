import 'package:flutter/material.dart';

class MentalHealthScreen extends StatefulWidget {
  const MentalHealthScreen({super.key});

  @override
  State<MentalHealthScreen> createState() =>
      _MentalHealthScreenState();
}

class _MentalHealthScreenState
    extends State<MentalHealthScreen> {

  final List<Map<String, dynamic>> questions = [

    {
      "question":
      "How often do you feel stressed?",
      "options": [
        "Rarely",
        "Sometimes",
        "Often",
      ],
    },

    {
      "question":
      "How is your sleep quality?",
      "options": [
        "Good",
        "Average",
        "Poor",
      ],
    },

    {
      "question":
      "Do you feel emotionally balanced?",
      "options": [
        "Yes",
        "Sometimes",
        "No",
      ],
    },

    {
      "question":
      "How often do you feel anxious?",
      "options": [
        "Rarely",
        "Sometimes",
        "Frequently",
      ],
    },
  ];

  int currentQuestion = 0;

  int score = 0;

  void answerQuestion(int points) {

    score += points;

    if (currentQuestion < questions.length - 1) {

      setState(() {
        currentQuestion++;
      });

    } else {

      showResult();
    }
  }

  void showResult() {

    String resultText = "";

    if (score <= 3) {

      resultText =
      "Your mental wellness looks good 😊";

    } else if (score <= 6) {

      resultText =
      "You may need some relaxation and self-care 🙂";

    } else {

      resultText =
      "Consider taking rest and talking to someone you trust ❤️";
    }

    showDialog(

      context: context,

      builder: (context) {

        return AlertDialog(

          title: const Text("Assessment Result"),

          content: Text(resultText),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);

                setState(() {

                  currentQuestion = 0;
                  score = 0;

                });
              },

              child: const Text("Retake"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final question = questions[currentQuestion];

    return Scaffold(

      appBar: AppBar(
        title: const Text("Mental Health Checkup"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value:
              (currentQuestion + 1) /
                  questions.length,
            ),

            const SizedBox(height: 40),

            Text(
              "Question ${currentQuestion + 1}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              question["question"],

              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ...List.generate(
              question["options"].length,

                  (index) {

                return Padding(
                  padding:
                  const EdgeInsets.only(bottom: 20),

                  child: SizedBox(
                    width: double.infinity,
                    height: 55,

                    child: ElevatedButton(

                      onPressed: () {

                        answerQuestion(index + 1);

                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.blue.shade50,

                        foregroundColor: Colors.black,

                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(18),
                        ),
                      ),

                      child: Text(
                        question["options"][index],

                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}