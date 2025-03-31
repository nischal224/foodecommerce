import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food/admin/home_admin.dart';

import 'package:food/widget/app_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Fixed this line

  // Set your Stripe publishable key before applying settings
  Stripe.publishableKey = publishableKey;
  await Stripe.instance.applySettings(); // Apply settings after the key is set

  // Initialize Firebase
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC4X5HCGw659gbzwsFvFHWhNerWBn9n1DM",
        appId: "1:579287322784:web:d40772cbbf397d68ca79c5",
        messagingSenderId: "579287322784",
        projectId: "flutter-firebase-6b8e9",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HungerHive',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeAdmin(),
      // FirebaseAuth.instance.currentUser == null ? Onboard() : LoginScreen(),
    );
  }
}
