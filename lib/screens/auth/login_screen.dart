import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../firebase_options.dart';
import 'signup_screen.dart'; // Import the SignUpScreen

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Firebase initialization is complete, show your UI
            return Center(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(5.h),
                  child: Sizer(
                    builder: (context, orientation, deviceType) {
                      return SingleChildScrollView(
                        // Wrap your Column with SingleChildScrollView
                        child: SizedBox(
                          width: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.food_bank_rounded,
                                size: 80.sp, // Adjust the size as needed
                                color: Colors.white,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                "Welcome to [App Name]",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  const Icon(Icons.email), // Icon for email
                                  SizedBox(width: 1.h),
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        hintText: "email",
                                      ),
                                      controller: _emailController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  const Icon(Icons.lock), // Icon for password
                                  SizedBox(width: 1.h),
                                  Expanded(
                                    child: TextField(
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        hintText: "password",
                                      ),
                                      controller: _passwordController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              SizedBox(
                                width: 30.w,
                                height: 7.h,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty) {
                                      Flushbar(
                                        message:
                                            "Error: Email or password can't be empty.",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      try {
                                        final email =
                                            _emailController.text.trim();
                                        final password =
                                            _passwordController.text.trim();
                                        final userCredential =
                                            await FirebaseAuth.instance
                                                .signInWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );

                                        // Check if login was successful
                                        if (userCredential.user != null) {
                                        } else {
                                          Flushbar(
                                            message: "Login failed.",
                                            duration:
                                                const Duration(seconds: 3),
                                          ).show(context);
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        Flushbar(
                                          message: e.code,
                                        ).show(context);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 3.h),
                              TextButton(
                                onPressed: () {
                                  print("Sign Up button pressed");
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Don't have an account? Sign up",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          } else {
            // Firebase is still initializing, show a loading indicator
            return const Center(
              child:
                  CircularProgressIndicator(), // Or any other loading indicator widget
            );
          }
        },
      ),
    );
  }
}
