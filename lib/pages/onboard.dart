import 'package:flutter/material.dart';
import 'package:food/pages/login.dart';
import 'package:food/widget/content_model.dart';
import 'package:food/widget/widget_support.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentPage = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: MediaQuery.of(context).size.height / 2,
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 20),
                      Text(
                        contents[i].title,
                        style: Appwidget.semiBoldTextFeildStyle(),
                      ),
                      SizedBox(height: 30),
                      Text(
                        contents[i].description,
                        style: Appwidget.boldTextFeildStyle(),
                      ),

                      SizedBox(height: 30),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),

                      // Container(
                      //   height: 60,
                      //   margin: EdgeInsets.all(40),
                      //   width: double.infinity,
                      //   child: Text(
                      //     "Next",
                      //     style: Appwidget.semiBoldTextFeildStyle(),
                      //   ),
                      // ),
                      SizedBox(height: 18),
                      GestureDetector(
                        onTap: () {
                          if (currentPage == contents.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                          _controller.nextPage(
                            duration: Duration(milliseconds: 100),
                            curve: Curves.decelerate,
                          );
                        },

                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          height: 50,
                          width: 180,

                          padding: const EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              currentPage == contents.length - 1
                                  ? "start"
                                  : "Next",
                              style: Appwidget.semiBoldTextFeildStyle(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Container(
          //   height: 100,
          //   width: double.infinity,
          //   margin: EdgeInsets.only(bottom: 20),
          //   child: Text("Next", style: Appwidget.semiBoldTextFeildStyle()),
          // ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      width: currentPage == index ? 18 : 7,
      height: 10,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: currentPage == index ? Colors.red : Colors.grey,
      ),
    );
  }
}
