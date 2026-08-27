import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile/setup_profile_screen.dart';
import 'bottom_nav_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool obscurePassword = true;

  bool obscureConfirmPassword = true;

  bool isLoading = false;

  Future<void> createAccount() async {

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all fields",
          ),
        ),
      );

      return;
    }

    if (passwordController.text !=
        confirmPasswordController.text) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Passwords do not match",
          ),
        ),
      );

      return;
    }

    try {

      setState(() {
        isLoading = true;
      });

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
           SetupProfileScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.message ?? "Signup Failed",
          ),
        ),
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final width =
        MediaQuery.of(context).size.width;

    return Scaffold(

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: Container(

            width:
            width > 700 ? 450 : double.infinity,

            padding: const EdgeInsets.all(30),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(30),

              boxShadow: [

                BoxShadow(
                  color:
                  Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const Center(
                  child: Icon(
                    Icons.psychology,
                    size: 80,
                    color: Colors.blue,
                  ),
                ),

                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    "Create Account",

                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                const Center(
                  child: Text(
                    "Join MindTrace Today ✨",

                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 35),

                const Text(
                  "Full Name",

                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: nameController,

                  decoration: const InputDecoration(
                    hintText: "Enter your full name",

                    prefixIcon:
                    Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Email",

                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: emailController,

                  decoration: const InputDecoration(
                    hintText: "Enter your email",

                    prefixIcon:
                    Icon(Icons.email),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Password",

                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,

                  decoration: InputDecoration(

                    hintText: "Enter your password",

                    prefixIcon:
                    const Icon(Icons.lock),

                    suffixIcon: IconButton(

                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),

                      onPressed: () {

                        setState(() {
                          obscurePassword =
                          !obscurePassword;
                        });

                      },
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Confirm Password",

                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller:
                  confirmPasswordController,

                  obscureText:
                  obscureConfirmPassword,

                  decoration: InputDecoration(

                    hintText:
                    "Re-enter password",

                    prefixIcon:
                    const Icon(Icons.lock),

                    suffixIcon: IconButton(

                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),

                      onPressed: () {

                        setState(() {
                          obscureConfirmPassword =
                          !obscureConfirmPassword;
                        });

                      },
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  height: 58,

                  child: ElevatedButton(

                    onPressed:
                    isLoading
                        ? null
                        : createAccount,

                    child: isLoading

                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )

                        : const Text(
                      "Create Account",

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(

                  child: TextButton(

                    onPressed: () {

                      Navigator.pop(context);

                    },

                    child: const Text(
                      "Already have an account?",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}