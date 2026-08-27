import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_nav_screen.dart';
class SetupProfileScreen extends StatefulWidget {
  SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() =>
      _SetupProfileScreenState();
}

class _SetupProfileScreenState
    extends State<SetupProfileScreen> {

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController friendNameController =
  TextEditingController();

  final TextEditingController friendPhoneController =
  TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadExistingData();
  }

  Future<void> loadExistingData() async {

    final prefs =
    await SharedPreferences.getInstance();

    nameController.text =
        prefs.getString("user_name") ?? "";

    phoneController.text =
        prefs.getString("user_phone") ?? "";

    friendNameController.text =
        prefs.getString("friend_name") ?? "";

    friendPhoneController.text =
        prefs.getString("friend_phone") ?? "";
  }
  // ================= SAVE PROFILE =================

  Future<void> saveProfile() async {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        friendNameController.text.isEmpty ||
        friendPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(
          content: Text(
            "Please fill all fields",
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    final prefs =
    await SharedPreferences.getInstance();

    // ================= SAVE DATA =================

    await prefs.setString(
      "user_name",
      nameController.text.trim(),
    );

    await prefs.setString(
      "user_phone",
      phoneController.text.trim(),
    );

    await prefs.setString(
      "friend_name",
      friendNameController.text.trim(),
    );

    await prefs.setString(
      "friend_phone",
      friendPhoneController.text.trim(),
    );

    await prefs.setBool(
      "profile_completed",
      true,
    );

    if (!mounted) return;

    // ================= GO TO HOME ================

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context, true);
    // ================= UI =================
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F8FC),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 20),

              // ================= HEADER =================

              const Center(

                child: CircleAvatar(

                  radius: 50,

                  backgroundColor:
                  Colors.blue,

                  child: Icon(

                    Icons.person,

                    color: Colors.white,

                    size: 55,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Center(

                child: Text(

                  "Complete Your Profile",

                  style: TextStyle(

                    fontSize: 30,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Center(

                child: Text(

                  "Help us personalize your wellness journey 🌿",

                  textAlign: TextAlign.center,

                  style: TextStyle(

                    fontSize: 16,

                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ================= NAME =================

              const Text(

                "Full Name",

                style: TextStyle(

                  fontWeight:
                  FontWeight.bold,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller: nameController,

                decoration: InputDecoration(

                  hintText:
                  "Enter your name",

                  prefixIcon:
                  const Icon(Icons.person),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(18),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ================= PHONE =================

              const Text(

                "Phone Number",

                style: TextStyle(

                  fontWeight:
                  FontWeight.bold,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller:
                phoneController,

                keyboardType:
                TextInputType.phone,

                decoration: InputDecoration(

                  hintText:
                  "Enter your phone number",

                  prefixIcon:
                  const Icon(Icons.phone),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(18),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // ================= EMERGENCY =================

              const Text(

                "Emergency Contact",

                style: TextStyle(

                  fontSize: 22,

                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              TextField(

                controller:
                friendNameController,

                decoration: InputDecoration(

                  hintText:
                  "Friend or Family Name",

                  prefixIcon:
                  const Icon(Icons.people),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(18),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(

                controller:
                friendPhoneController,

                keyboardType:
                TextInputType.phone,

                decoration: InputDecoration(

                  hintText:
                  "Emergency Contact Number",

                  prefixIcon:
                  const Icon(Icons.call),

                  filled: true,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(18),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 45),

              // ================= BUTTON =================

              SizedBox(

                width: double.infinity,

                height: 58,

                child: ElevatedButton(

                  onPressed:
                  isLoading
                      ? null
                      : saveProfile,

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

                  child: isLoading

                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )

                      : const Text(

"Save Profile",

                    style: TextStyle(

                      fontSize: 18,

                      color: Colors.white,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}