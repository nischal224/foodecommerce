// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:food/widget/app_constant.dart';
// import 'package:food/widget/widget_support.dart';
// import 'package:http/http.dart' as http;
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Wallet extends StatefulWidget {
//   const Wallet({super.key});

//   @override
//   State<Wallet> createState() => _WalletState();
// }

// class _WalletState extends State<Wallet> {
//   Map<String, dynamic>? paymentIntent;
//   double walletBalance = 0.0; // Track wallet balance
//   final TextEditingController customAmountController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     fetchWalletBalance(); // Fetch balance from Firestore when page loads
//   }

//   @override
//   void dispose() {
//     customAmountController.dispose();
//     super.dispose();
//   }

//   // ✅ Fetch wallet balance from Firestore
//   Future<void> fetchWalletBalance() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       DocumentSnapshot snapshot =
//           await FirebaseFirestore.instance
//               .collection('users')
//               .doc(user.uid)
//               .get();

//       if (snapshot.exists && snapshot.data() != null) {
//         setState(() {
//           walletBalance = (snapshot['wallet'] as num?)?.toDouble() ?? 0.0;
//         });
//       }
//     }
//   }

//   // ✅ Update wallet balance in Firestore
//   Future<void> updateWalletBalance(double newAmount) async {
//     User? user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
//         'wallet': newAmount,
//       }, SetOptions(merge: true));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.only(top: 50.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Material(
//               elevation: 2.0,
//               child: Container(
//                 padding: const EdgeInsets.only(bottom: 10.0),
//                 child: Center(
//                   child: Text(
//                     "Wallet",
//                     style: Appwidget.semiBoldTextFeildStyle(),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),
//             Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 10.0,
//                 vertical: 10.0,
//               ),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(color: const Color(0xFFF2F2F2)),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     "images/wallet.png",
//                     fit: BoxFit.cover,
//                     height: 100.0,
//                     width: 150.0,
//                   ),
//                   const SizedBox(width: 40),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Your Wallet",
//                         style: Appwidget.headlineTextFeildStyle(),
//                       ),
//                       const SizedBox(height: 5.0),
//                       Text(
//                         "NPR ${walletBalance.toStringAsFixed(2)}",
//                         style: Appwidget.semiBoldTextFeildStyle(),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             const Padding(
//               padding: EdgeInsets.all(15.0),
//               child: Text(
//                 "Add Money",
//                 style: TextStyle(
//                   color: Color(0xFF333333),
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   fontFamily: 'Poppins',
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children:
//                     [100, 500, 1000, 2000].map((amount) {
//                       return GestureDetector(
//                         onTap: () => makePayment(amount.toString()),
//                         child: Container(
//                           margin: const EdgeInsets.symmetric(horizontal: 8),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: const Color(0xFFE9E2E2)),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: Text(
//                             "NPR $amount",
//                             style: Appwidget.semiBoldTextFeildStyle(),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> makePayment(String amount) async {
//     try {
//       if (double.tryParse(amount) == null || double.parse(amount) <= 0) {
//         throw Exception('Please enter a valid amount');
//       }

//       paymentIntent = await createPaymentIntent(amount, "NPR");

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntent!['client_secret'],
//           style: ThemeMode.dark,
//           merchantDisplayName: "HungerHive",
//         ),
//       );

//       await displayPaymentSheet(amount);
//     } catch (e) {
//       print('Payment exception: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Payment failed: ${e.toString()}")),
//       );
//     }
//   }

//   Future<void> displayPaymentSheet(String amount) async {
//     try {
//       await Stripe.instance.presentPaymentSheet();

//       double addedAmount = double.tryParse(amount) ?? 0.0;

//       setState(() {
//         walletBalance += addedAmount;
//       });

//       await updateWalletBalance(
//         walletBalance,
//       ); // ✅ Save updated balance to Firestore

//       showDialog(
//         context: context,
//         builder:
//             (_) => AlertDialog(
//               title: const Text("Payment Successful"),
//               content: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Icon(Icons.check_circle, color: Colors.green, size: 50),
//                   const SizedBox(height: 10),
//                   Text(
//                     "NPR ${addedAmount.toStringAsFixed(2)} added to your wallet",
//                   ),
//                 ],
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text("OK"),
//                 ),
//               ],
//             ),
//       );

//       paymentIntent = null;
//     } on StripeException catch (e) {
//       print("Stripe error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text("Payment cancelled: ${e.error.localizedMessage}"),
//         ),
//       );
//     } catch (e) {
//       print('Payment error: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("An error occurred: ${e.toString()}")),
//       );
//     }
//   }

//   Future<Map<String, dynamic>> createPaymentIntent(
//     String amount,
//     String currency,
//   ) async {
//     try {
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $secretKey',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'amount': calculateAmount(amount),
//           'currency': currency,
//           'payment_method_types[]': 'card',
//         },
//       );

//       return jsonDecode(response.body);
//     } catch (e) {
//       throw Exception('Failed to create payment intent');
//     }
//   }

//   String calculateAmount(String amount) {
//     return (double.parse(amount) * 100).toInt().toString();
//   }
// }

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food/widget/app_constant.dart';
import 'package:food/widget/widget_support.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  Map<String, dynamic>? paymentIntent;
  double walletBalance = 0.0;
  String userEmail = "Loading...";
  final TextEditingController customAmountController = TextEditingController();

  // Save user data to Firestore after signup
  Future<void> saveUserData(String email) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': email,
      'walletBalance': 0.0, // Initialize wallet balance to 0.0
    });
  }

  // Fetch the user data from Firestore
  Future<Map<String, dynamic>> fetchUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      return {
        'email': data['email'] ?? 'No Email',
        'walletBalance': data['walletBalance'] ?? 0.0,
      };
    } else {
      // If user data doesn't exist, create it
      await saveUserData(
        FirebaseAuth.instance.currentUser!.email ?? 'No Email',
      );
      return {
        'email': FirebaseAuth.instance.currentUser!.email ?? 'No Email',
        'walletBalance': 0.0,
      };
    }
  }

  // Update the wallet balance in Firestore
  Future<void> updateWalletBalance(double addedAmount) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(userId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(userDoc);

      if (!snapshot.exists) {
        transaction.set(userDoc, {
          'walletBalance': addedAmount,
          'email': FirebaseAuth.instance.currentUser?.email ?? 'No Email',
        });
      } else {
        double currentBalance = (snapshot['walletBalance'] ?? 0.0).toDouble();
        transaction.update(userDoc, {
          'walletBalance': currentBalance + addedAmount,
        });
      }
    });

    setState(() {
      walletBalance += addedAmount;
    });
  }

  @override
  void dispose() {
    customAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text("Wallet")),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text("Wallet")),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (snapshot.hasData) {
          userEmail = snapshot.data!['email'];
          walletBalance = snapshot.data!['walletBalance'];

          return Scaffold(
            body: Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2.0,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Center(
                        child: Text(
                          "Wallet",
                          style: Appwidget.semiBoldTextFeildStyle(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 10.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: const Color(0xFFF2F2F2)),
                    child: Row(
                      children: [
                        Image.asset(
                          "images/wallet.png",
                          fit: BoxFit.cover,
                          height: 100.0,
                          width: 150.0,
                        ),
                        const SizedBox(width: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   "Email: $userEmail",
                            //   style: Appwidget.headlineTextFeildStyle(),
                            // ),
                            const SizedBox(height: 5.0),
                            Text(
                              "Wallet: NPR ${walletBalance.toStringAsFixed(2)}",
                              style: Appwidget.semiBoldTextFeildStyle(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Add Money",
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:
                          [100, 500, 1000, 2000].map((amount) {
                            return GestureDetector(
                              onTap: () => makePayment(amount.toString()),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFE9E2E2),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  "NPR $amount",
                                  style: Appwidget.semiBoldTextFeildStyle(),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text("Add Custom Amount"),
                              content: TextField(
                                controller: customAmountController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: "Enter amount in NPR",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    if (customAmountController
                                        .text
                                        .isNotEmpty) {
                                      Navigator.pop(context);
                                      makePayment(customAmountController.text);
                                    }
                                  },
                                  child: const Text("Add"),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 65.0),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Text(
                        "Add Custom Amount",
                        style: Appwidget.semiBoldTextFeildStyle(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text("Wallet")),
          body: const Center(child: Text("No Data Found")),
        );
      },
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      if (double.tryParse(amount) == null || double.parse(amount) <= 0) {
        throw Exception('Please enter a valid amount');
      }

      paymentIntent = await createPaymentIntent(amount, "NPR");

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: "HungerHive",
        ),
      );

      await displayPaymentSheet(amount);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: ${e.toString()}")),
      );
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      double addedAmount = double.tryParse(amount) ?? 0.0;

      await updateWalletBalance(addedAmount);

      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text("Payment Successful"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    "NPR ${addedAmount.toStringAsFixed(2)} added to your wallet",
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
      );

      paymentIntent = null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${e.toString()}")),
      );
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': (double.parse(amount) * 100).toInt().toString(),
          'currency': currency,
          'payment_method_types[]': 'card',
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      throw Exception('Failed to create payment intent');
    }
  }
}
