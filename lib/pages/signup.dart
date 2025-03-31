import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import for Firestore
import 'package:flutter/material.dart';
import 'package:food/pages/bottonnav.dart';
import 'package:food/pages/login.dart';
import 'package:food/service/shared_pref.dart';
import 'package:food/widget/widget_support.dart';
import 'package:random_string/random_string.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  void _signup() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Passwords do not match')));
        return;
      }
      setState(() {
        _isLoading = true;
      });
      try {
        // 1. Create user with Firebase Authentication
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            );
        print('User signed up: ${userCredential.user!.email}');

        // 2. Generate a unique ID for the user (if needed, otherwise use Firebase UID)
        String email = randomAlphaNumeric(10);

        // 3. Create the Firestore document for the user
        Map<String, dynamic> adduserInfo = {
          "walletBalance": 0.0, // Initialize wallet balance to 0.0
          "userId": email, // Store the generated ID or use Firebase UID
        };

        // 4. Save user info to Firestore without showing email in UI
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(adduserInfo);

        // 5. Optionally, save the user data locally for future reference
        await SharedPreferenceHelper().saveUserEmail(
          _emailController.text,
        ); // Email will be saved in Shared Preferences for later use
        await SharedPreferenceHelper().saveUserWallet('0');
        await SharedPreferenceHelper().saveUserId(email);

        // 6. Navigate to the Bottom Navigation Screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Bottonnav()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: ColorConstants.primarycolor),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shadowColor: Colors.pinkAccent,
              color: ColorConstants.secondarycolor,
              elevation: 10,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.pink, width: 2.0),
                borderRadius: BorderRadius.circular(25),
              ),
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo Section
                      Image.asset(
                        'images/logo.png', // Add your logo here
                        height: 180,
                        width: 180,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.textcolor,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sign up to get started',
                        style: TextStyle(fontSize: 16, color: Colors.white70),
                      ),
                      SizedBox(height: 20),
                      // Email Input Field (User enters the email here, but it's not displayed in the UI after signup)
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: ColorConstants.textcolor,
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: ColorConstants.textcolor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      // Password Input Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: ColorConstants.textcolor,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: ColorConstants.textcolor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),
                      // Confirm Password Input Field
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color: ColorConstants.textcolor,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: ColorConstants.textcolor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      // Signup Button
                      ElevatedButton(
                        onPressed: _isLoading ? null : _signup,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 90,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.redAccent,
                        ),
                        child:
                            _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                      ),
                      SizedBox(height: 10),
                      // Already have an account Text
                      TextButton(
                        onPressed:
                            _isLoading
                                ? null
                                : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                        child: Text(
                          "Already have an account? Login",
                          style: TextStyle(
                            color: ColorConstants.textcolor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
