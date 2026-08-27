import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_nav_screen.dart';
import 'signup_screen.dart';
import 'daily_mood_popup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool obscurePassword = true;

  bool isLoading = false;

  // LOGIN
  Future<void> loginUser() async {

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
              "Please fill all fields"),
        ),
      );

      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email:
        emailController.text.trim(),

        password:
        passwordController.text.trim(),
      );

      final prefs =
      await SharedPreferences.getInstance();

      // SAVE LOGIN SESSION
      await prefs.setBool(
        "is_logged_in",
        true,
      );

      final today =
      DateTime.now()
          .toString()
          .split(' ')[0];

      final savedDate =
      prefs.getString(
        "mood_date",
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: const Text(
              "Login Successful ✅"),

          backgroundColor:
          Colors.green,

          behavior:
          SnackBarBehavior.floating,
        ),
      );

      if (savedDate == today) {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder:
                (_) =>
            const BottomNavScreen(),
          ),
        );

      } else {

        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder:
                (_) =>
            const DailyMoodPopup(),
          ),
        );
      }

    } on FirebaseAuthException catch (e) {

      String error = "";

      switch (e.code) {

        case "user-not-found":

          error =
          "Account not found";
          break;

        case "wrong-password":

          error =
          "Wrong password";
          break;

        case "invalid-email":

          error =
          "Invalid email";
          break;

        case "invalid-credential":

          error =
          "Invalid credentials";
          break;

        default:

          error =
          "Login failed";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(error),
        ),
      );

    } finally {

      if (mounted) {

        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // FORGOT PASSWORD
  void resetPassword() {

    final controller =
    TextEditingController();

    showDialog(

      context: context,

      builder: (_) {

        return AlertDialog(

          title:
          const Text(
              "Reset Password"),

          content:
          TextField(

            controller:
            controller,

            decoration:
            const InputDecoration(

              hintText:
              "Enter Email",
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(
                    context);
              },

              child:
              const Text(
                  "Cancel"),
            ),

            ElevatedButton(

              onPressed:
                  () async {

                try {

                  await FirebaseAuth
                      .instance
                      .sendPasswordResetEmail(

                    email:
                    controller.text
                        .trim(),
                  );

                  if (!mounted)
                    return;

                  Navigator.pop(
                      context);

                  ScaffoldMessenger.of(
                      context)
                      .showSnackBar(

                    const SnackBar(

                      content: Text(
                          "Reset mail sent"),
                    ),
                  );

                } catch (_) {}
              },

              child:
              const Text(
                  "Send"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(
          0xFFF7F8FC),

      body: Center(

        child:
        SingleChildScrollView(

          padding:
          const EdgeInsets.all(
              25),

          child:
          Container(

            padding:
            const EdgeInsets.all(
                30),

            decoration:
            BoxDecoration(

              color:
              Colors.white,

              borderRadius:
              BorderRadius.circular(
                  30),
            ),

            child:
            Column(

              children: [

                const Icon(

                  Icons.psychology,

                  size: 80,

                  color:
                  Colors.blue,
                ),

                const SizedBox(
                    height: 20),

                const Text(

                  "MindTrace",

                  style:
                  TextStyle(

                    fontSize:
                    30,

                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),

                const SizedBox(
                    height: 8),

                const Text(
                    "Welcome Back 👋"),

                const SizedBox(
                    height: 35),

                TextField(

                  controller:
                  emailController,

                  decoration:
                  const InputDecoration(

                    labelText:
                    "Email",

                    prefixIcon:
                    Icon(
                        Icons.email),
                  ),
                ),

                const SizedBox(
                    height: 20),

                TextField(

                  controller:
                  passwordController,

                  obscureText:
                  obscurePassword,

                  decoration:
                  InputDecoration(

                    labelText:
                    "Password",

                    prefixIcon:
                    const Icon(
                        Icons.lock),

                    suffixIcon:
                    IconButton(

                      onPressed:
                          () {

                        setState(() {

                          obscurePassword =
                          !obscurePassword;
                        });
                      },

                      icon:
                      Icon(

                        obscurePassword

                            ? Icons
                            .visibility_off

                            : Icons
                            .visibility,
                      ),
                    ),
                  ),
                ),

                Align(

                  alignment:
                  Alignment
                      .centerRight,

                  child:
                  TextButton(

                    onPressed:
                    resetPassword,

                    child:
                    const Text(
                        "Forgot Password?"),
                  ),
                ),

                const SizedBox(
                    height: 20),

                SizedBox(

                  width:
                  double.infinity,

                  height: 58,

                  child:
                  ElevatedButton(

                    onPressed:
                    isLoading
                        ? null
                        : loginUser,

                    child:
                    isLoading

                        ? const CircularProgressIndicator()

                        : const Text(
                        "Login"),
                  ),
                ),

                const SizedBox(
                    height: 10),

                TextButton(

                  onPressed:
                      () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:
                            (_) =>
                        const SignupScreen(),
                      ),
                    );
                  },

                  child:
                  const Text(
                      "Create New Account"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}