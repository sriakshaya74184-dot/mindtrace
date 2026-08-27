import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  const EmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Emergency Support"),
        centerTitle: true,
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              // ================= SUPPORT CARD =================

              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(

                  color: Colors.red.shade50,

                  borderRadius:
                  BorderRadius.circular(25),
                ),

                child: const Column(

                  children: [

                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 70,
                    ),

                    SizedBox(height: 20),

                    Text(
                      "You Are Not Alone ❤️",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 26,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Take a deep breath.\nSupport is always available for you.",

                      textAlign: TextAlign.center,

                      style: TextStyle(
                        fontSize: 17,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // ================= CONTACTS =================

              const Text(

                "Emergency Contacts",

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              buildSupportCard(
                Icons.favorite,
                "Mental Health Helpline",
                "+91 1800-599-0019",
              ),

              buildSupportCard(
                Icons.local_hospital,
                "Emergency Medical Services",
                "108",
              ),

              buildSupportCard(
                Icons.people,
                "Trusted Emergency Contact",
                "Configured in Profile",
              ),

              const SizedBox(height: 30),

              // ================= NOTE =================

              Container(

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(

                  color: Colors.blue.shade50,

                  borderRadius:
                  BorderRadius.circular(18),
                ),

                child: const Text(

                  "In case of urgent situations, contact your trusted emergency person or local emergency services immediately.",

                  textAlign: TextAlign.center,

                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildSupportCard(
      IconData icon,
      String title,
      String number,
      ) {

    return Card(

      elevation: 3,

      margin: const EdgeInsets.only(
        bottom: 18,
      ),

      shape: RoundedRectangleBorder(
        borderRadius:
        BorderRadius.circular(18),
      ),

      child: ListTile(

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),

        leading: CircleAvatar(

          radius: 25,

          backgroundColor:
          Colors.red.shade100,

          child: Icon(
            icon,
            color: Colors.red,
            size: 28,
          ),
        ),

        title: Text(

          title,

          style: const TextStyle(
            fontWeight:
            FontWeight.bold,
            fontSize: 16,
          ),
        ),

        subtitle: Padding(

          padding:
          const EdgeInsets.only(
            top: 5,
          ),

          child: Text(

            number,

            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}