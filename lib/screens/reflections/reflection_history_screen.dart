import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReflectionHistoryScreen extends StatefulWidget {
  const ReflectionHistoryScreen({super.key});

  @override
  State<ReflectionHistoryScreen> createState() =>
      _ReflectionHistoryScreenState();
}

class _ReflectionHistoryScreenState
    extends State<ReflectionHistoryScreen> {

  String reflection = "";

  @override
  void initState() {
    super.initState();
    loadReflection();
  }

  Future<void> loadReflection() async {

    final prefs =
    await SharedPreferences.getInstance();

    setState(() {

      reflection =
          prefs.getString(
            "daily_reflection",
          ) ??
              "No reflections saved yet.";
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "My Reflections",
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Container(

          width: double.infinity,

          padding: const EdgeInsets.all(20),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
            BorderRadius.circular(20),

            boxShadow: const [

              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              ),
            ],
          ),

          child: Text(

            reflection,

            style: const TextStyle(
              fontSize: 18,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}