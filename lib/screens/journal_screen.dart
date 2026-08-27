import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() =>
      _JournalScreenState();
}

class _JournalScreenState
    extends State<JournalScreen> {

  final TextEditingController
  journalController =
  TextEditingController();

  List<Map<String, String>>
  journalEntries = [];

  @override
  void initState() {

    super.initState();

    loadEntries();
  }

  // ================= LOAD ENTRIES =================

  Future<void> loadEntries() async {

    final prefs =
    await SharedPreferences.getInstance();

    final data =
    prefs.getString("journal_entries");

    if (data != null) {

      final List decoded =
      jsonDecode(data);

      setState(() {

        journalEntries = decoded
            .map<Map<String, String>>(
              (item) => {
            "text":
            item["text"].toString(),

            "date":
            item["date"].toString(),
          },
        ).toList();
      });
    }
  }

  // ================= SAVE ENTRIES =================

  Future<void> saveEntries() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.setString(
      "journal_entries",
      jsonEncode(journalEntries),
    );
  }

  // ================= ADD ENTRY =================

  void addEntry() {

    if (journalController
        .text
        .trim()
        .isEmpty) {
      return;
    }

    final now = DateTime.now();

    final formattedDate =
        "${now.day}/${now.month}/${now.year}";

    setState(() {

      journalEntries.insert(0, {

        "text":
        journalController.text.trim(),

        "date":
        formattedDate,
      });
    });

    saveEntries();

    journalController.clear();
  }

  // ================= DELETE ENTRY =================

  void deleteEntry(int index) {

    setState(() {

      journalEntries.removeAt(index);
    });

    saveEntries();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F8FC),

      appBar: AppBar(

        title: const Text(
          "Memory Journal",
        ),

        centerTitle: true,
      ),

      body: Padding(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [

            // ================= INPUT =================

            Container(

              padding:
              const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                BorderRadius.circular(24),

                boxShadow: [

                  BoxShadow(

                    color:
                    Colors.black.withOpacity(
                        0.05),

                    blurRadius: 10,

                    offset:
                    const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(

                children: [

                  TextField(

                    controller:
                    journalController,

                    maxLines: 5,

                    decoration:
                    const InputDecoration(

                      hintText:
                      "Write your thoughts here...",

                      border:
                      InputBorder.none,
                    ),
                  ),

                  const SizedBox(height: 15),

                  SizedBox(

                    width: double.infinity,

                    height: 52,

                    child: ElevatedButton(

                      onPressed: addEntry,

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

                      child: const Text(

                        "Save Journal",

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 16,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= TITLE =================

            const Align(

              alignment: Alignment.centerLeft,

              child: Text(

                "Your Memories",

                style: TextStyle(

                  fontSize: 22,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ================= LIST =================

            Expanded(

              child: journalEntries.isEmpty

                  ? const Center(

                child: Text(

                  "No journal entries yet",

                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )

                  : ListView.builder(

                itemCount:
                journalEntries.length,

                itemBuilder:
                    (context, index) {

                  final entry =
                  journalEntries[index];

                  return Container(

                    margin:
                    const EdgeInsets.only(
                        bottom: 16),

                    padding:
                    const EdgeInsets.all(
                        18),

                    decoration:
                    BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                      BorderRadius.circular(
                          22),

                      boxShadow: [

                        BoxShadow(

                          color: Colors.black
                              .withOpacity(
                              0.05),

                          blurRadius: 10,

                          offset:
                          const Offset(
                              0, 4),
                        ),
                      ],
                    ),

                    child: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        Row(

                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                          children: [

                            Text(

                              entry["date"]!,

                              style:
                              const TextStyle(

                                color:
                                Colors.grey,

                                fontWeight:
                                FontWeight
                                    .w600,
                              ),
                            ),

                            GestureDetector(

                              onTap: () {
                                deleteEntry(
                                    index);
                              },

                              child: const Icon(

                                Icons.delete,

                                color:
                                Colors.red,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 12),

                        Text(

                          entry["text"]!,

                          style:
                          const TextStyle(

                            fontSize: 16,

                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}