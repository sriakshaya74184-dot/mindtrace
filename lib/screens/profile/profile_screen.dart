import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'setup_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  String name = "";
  String phone = "";
  String friendName = "";
  String friendPhone = "";

  int moodCount = 0;
  int reflectionCount = 0;
  int habitCount = 0;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {

    final prefs =
    await SharedPreferences.getInstance();

    int totalMoodLogs = 0;

    final moodData =
    prefs.getString("mood_history");

    if (moodData != null) {

      final List decoded =
      jsonDecode(moodData);

      totalMoodLogs = decoded.length;
    }

    int totalHabits = 0;

    final habitsData =
    prefs.getString("habits");

    if (habitsData != null) {

      final List decodedHabits =
      jsonDecode(habitsData);

      totalHabits = decodedHabits
          .where(
            (habit) =>
        habit["completed"] == true,
      )
          .length;
    }

    final reflection =
    prefs.getString(
      "daily_reflection",
    );

    int totalReflections =
    (reflection != null &&
        reflection.isNotEmpty)
        ? 1
        : 0;

    setState(() {

      name =
          prefs.getString("user_name") ??
              "";

      phone =
          prefs.getString("user_phone") ??
              "";

      friendName =
          prefs.getString("friend_name") ??
              "";

      friendPhone =
          prefs.getString("friend_phone") ??
              "";

      moodCount = totalMoodLogs;

      reflectionCount =
          totalReflections;

      habitCount = totalHabits;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "My Profile",
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 10),

            CircleAvatar(
              radius: 55,
              backgroundColor:
              Colors.blue.shade100,
              child: const Icon(
                Icons.person,
                size: 55,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              name.isEmpty
                  ? "MindTrace User"
                  : name,
              style:
              const TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Your mental wellness matters 💙",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // PERSONAL INFO

            buildSectionTitle(
              "Personal Information",
            ),

            const SizedBox(height: 15),

            buildProfileTile(
              "Name",
              name,
              Icons.person,
            ),

            const SizedBox(height: 12),

            buildProfileTile(
              "Phone Number",
              phone,
              Icons.phone,
            ),

            const SizedBox(height: 25),

            // EMERGENCY CONTACT

            buildSectionTitle(
              "Emergency Contact",
            ),

            const SizedBox(height: 15),

            buildProfileTile(
              "Contact Name",
              friendName,
              Icons.people,
            ),

            const SizedBox(height: 12),

            buildProfileTile(
              "Contact Number",
              friendPhone,
              Icons.call,
            ),

            const SizedBox(height: 25),

            // JOURNEY

            buildSectionTitle(
              "MindTrace Journey",
            ),

            const SizedBox(height: 15),

            Row(
              children: [

                Expanded(
                  child:
                  buildStatCard(
                    moodCount
                        .toString(),
                    "Mood Logs",
                  ),
                ),

                const SizedBox(
                    width: 10),

                Expanded(
                  child:
                  buildStatCard(
                    reflectionCount
                        .toString(),
                    "Reflections",
                  ),
                ),

                const SizedBox(
                    width: 10),

                Expanded(
                  child:
                  buildStatCard(
                    habitCount
                        .toString(),
                    "Habits",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // CURRENT FOCUS

            buildSectionTitle(
              "Current Focus",
            ),

            const SizedBox(height: 12),

            buildInfoCard(
              Icons.track_changes,
              "Building a healthier and more mindful lifestyle.",
            ),

            const SizedBox(height: 25),

            // DAILY MOTIVATION

            buildSectionTitle(
              "Daily Motivation",
            ),

            const SizedBox(height: 12),

            buildInfoCard(
              Icons.lightbulb,
              "Small daily improvements lead to lasting results.",
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child:
              ElevatedButton.icon(

                onPressed:
                    () async {

                  await Navigator
                      .push(

                    context,

                    MaterialPageRoute(
                      builder:
                          (_) =>
                          SetupProfileScreen(),
                    ),
                  );

                  await loadProfile();
                },

                icon: const Icon(
                  Icons.edit,
                ),

                label: const Text(
                  "Edit Profile",
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildProfileTile(
      String title,
      String value,
      IconData icon,
      ) {

    return Container(

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
            20),

        boxShadow: [

          BoxShadow(
            color: Colors.black
                .withOpacity(
                0.05),

            blurRadius: 8,
          ),
        ],
      ),

      child: Row(

        children: [

          CircleAvatar(

            radius: 22,

            backgroundColor:
            Colors.blue.shade100,

            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment
                  .start,

              children: [

                Text(
                  title,
                  style:
                  const TextStyle(
                    color:
                    Colors.grey,
                  ),
                ),

                const SizedBox(
                    height: 4),

                Text(

                  value.isEmpty
                      ? "Not Set"
                      : value,

                  style:
                  const TextStyle(

                    fontSize: 18,

                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoCard(
      IconData icon,
      String text,
      ) {

    return Container(

      width: double.infinity,

      padding:
      const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
            20),

        boxShadow: [

          BoxShadow(
            color: Colors.black
                .withOpacity(
                0.05),
            blurRadius: 8,
          ),
        ],
      ),

      child: Row(

        children: [

          Icon(
            icon,
            color: Colors.blue,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              text,
              style:
              const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(
      String title) {

    return Align(

      alignment:
      Alignment.centerLeft,

      child: Text(

        title,

        style:
        const TextStyle(

          fontSize: 20,

          fontWeight:
          FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildStatCard(
      String value,
      String title,
      ) {

    return Container(

      padding:
      const EdgeInsets.symmetric(
        vertical: 18,
      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(
            18),

        boxShadow: [

          BoxShadow(
            color: Colors.black
                .withOpacity(
                0.05),
            blurRadius: 8,
          ),
        ],
      ),

      child: Column(

        children: [

          Text(

            value,

            style:
            const TextStyle(

              fontSize: 24,

              fontWeight:
              FontWeight.bold,

              color:
              Colors.blue,
            ),
          ),

          const SizedBox(
              height: 5),

          Text(
            title,
            style:
            const TextStyle(
              color:
              Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}