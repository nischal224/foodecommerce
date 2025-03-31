import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/pages/signup.dart';
import 'package:food/widget/widget_support.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailcontroller = TextEditingController();
  final bool _isloading = false;

  String email = '';

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("password Reset Email has been send !")),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "No User Found for that email",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primarycolor,
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },

                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorConstants.textcolor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.0),
            Container(
              child: Text(
                "Password Recovery",
                style: TextStyle(
                  color: ColorConstants.textcolor,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Enter your Email",
              style: TextStyle(
                color: ColorConstants.textcolor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 60.0),
            Expanded(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextFormField(
                          controller: emailcontroller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter email';
                            }
                            return null;
                          },
                          style: TextStyle(color: ColorConstants.textcolor),
                          decoration: InputDecoration(
                            labelText: "Email",

                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: ColorConstants.textcolor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: ColorConstants.textcolor,
                              size: 30.0,
                            ),
                            // border: InputBorder.none,
                          ),
                        ),
                      ),

                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                email = emailcontroller.text;
                              });
                              resetPassword();
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.redAccent,
                            ),

                            // margin: EdgeInsets.only(left: 60.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Send Email",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            child: TextButton(
                              onPressed:
                                  _isloading
                                      ? null
                                      : () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => SignupScreen(),
                                          ),
                                        );
                                      },
                              child: Text(
                                "Don't have an account?? Signup",
                                style: TextStyle(
                                  color: ColorConstants.textcolor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
