import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../firebase_options.dart';
import '../../widgets/address.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _addressController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _addressController.dispose();
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
            return Center(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(5.h),
                  child: Sizer(
                    builder: (context, orientation, deviceType) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          width: 100.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.food_bank_rounded,
                                size: 80.sp,
                                color: Colors.white,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                "Welcome to [app Name]",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                "Create an account",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  const Icon(Icons.person),
                                  SizedBox(width: 1.h),
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Name",
                                      ),
                                      controller: _usernameController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  const Icon(Icons.email),
                                  SizedBox(width: 1.h),
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                      ),
                                      controller: _emailController,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              Row(
                                children: [
                                  const Icon(Icons.lock),
                                  SizedBox(width: 1.h),
                                  Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                      ),
                                      controller: _passwordController,
                                      obscureText: true,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                    ),
                                  ),
                                ],
                              ),
                              SearchField(
                                hintText: 'Address',
                                controller: _addressController,
                              ),
                              SizedBox(height: 4.h),
                              SizedBox(
                                width: 30.w,
                                height: 7.h,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty ||
                                        _usernameController.text.isEmpty ||
                                        _addressController.text.isEmpty) {
                                      Flushbar(
                                        message:
                                            "Error: Email, password, address or username can't be empty",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      final email =
                                          _emailController.text.trim();
                                      final password =
                                          _passwordController.text.trim();
                                      final username =
                                          _usernameController.text.trim();
                                      final address =
                                          _addressController.text.trim();

                                      try {
                                        final userCredential =
                                            await FirebaseAuth.instance
                                                .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );

                                        if (userCredential.user != null) {
                                          // Create a new document in Firestore with the user's data
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(userCredential.user!.uid)
                                              .set({
                                            'email': email,
                                            'username': username,
                                            'address': address
                                          });

                                          // Print a message on successful registration
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        Flushbar(
                                          message:
                                              e.message ?? 'An error occurred',
                                        ).show(
                                            context); // Call the show method to display the Flushbar
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text(
                                    "Sign Up",
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
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Already have an account? Login",
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
