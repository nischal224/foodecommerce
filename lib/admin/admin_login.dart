import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/admin/home_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2,
              ),
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(
                    MediaQuery.of(context).size.width,
                    200.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      "Let's start with \nAdmin",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Material(
                      elevation: 3.0,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 50.0),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20.0,
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 160, 160, 147),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter username';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Username",
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(255, 160, 160, 147),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              padding: EdgeInsets.only(
                                left: 20.0,
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color.fromARGB(255, 160, 160, 147),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: userPasswordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter password';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: Color.fromARGB(240, 160, 160, 147),
                                    ),
                                  ),
                                  obscureText: true,
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            GestureDetector(
                              onTap: () {
                                if (_formkey.currentState?.validate() ??
                                    false) {
                                  loginAdmin();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  loginAdmin() async {
    try {
      // Get the document that matches the username
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('Admin')
              .where('id', isEqualTo: usernameController.text.trim())
              .get();

      if (snapshot.docs.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Username not found')));
      } else {
        var adminData = snapshot.docs.first.data() as Map<String, dynamic>;

        // Compare password
        if (adminData['password'] != userPasswordController.text.trim()) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Incorrect password')));
        } else {
          // Navigate to the admin home page
          Route route = MaterialPageRoute(builder: (context) => HomeAdmin());
          Navigator.pushReplacement(context, route);
        }
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }
}
