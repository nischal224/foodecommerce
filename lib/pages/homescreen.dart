import 'package:flutter/material.dart';
import 'package:food/pages/details.dart';
import 'package:food/widget/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool icecream = false, burger = false, salad = false, pizza = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          // color: Colors.amber,
          // height: MediaQuery.of(context).size.height * 2,
          margin: EdgeInsets.only(top: 45, left: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Welcome", style: Appwidget.boldTextFeildStyle()),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text("Delicious Food", style: Appwidget.headlineTextFeildStyle()),
              Text(
                "Descover And Get Great Food",
                style: Appwidget.lightTextFeildStyle(),
              ),
              SizedBox(height: 20),
              Container(margin: EdgeInsets.only(right: 20), child: showItem()),

              SizedBox(height: 30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details()),
                          ),
                      child: Container(
                        margin: EdgeInsets.all(4),
                        child: Material(
                          elevation: 8.0,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "images/salad2.jpg",
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 150,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Veggie Taco Hash",
                                  style: Appwidget.semiBoldTextFeildStyle(),
                                ),
                                SizedBox(height: 5),

                                Text(
                                  "Fresh And Healthy",
                                  style: Appwidget.lightTextFeildStyle(),
                                ),
                                SizedBox(height: 5),

                                Text(
                                  "NPR250",
                                  style: Appwidget.semiBoldTextFeildStyle(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      margin: EdgeInsets.all(4),
                      child: Material(
                        elevation: 8.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/salad1.jpg",
                                fit: BoxFit.cover,
                                height: 150,
                                width: 150,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Mix Veg Salad",
                                style: Appwidget.semiBoldTextFeildStyle(),
                              ),
                              SizedBox(height: 5),

                              Text(
                                "Spicy with Onion",
                                style: Appwidget.lightTextFeildStyle(),
                              ),
                              SizedBox(height: 5),

                              Text(
                                "NPR350",
                                style: Appwidget.semiBoldTextFeildStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "images/salad2.jpg",
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 20.0),
                          Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Mediterranean Chickpea Salad",
                                  style: Appwidget.semiBoldTextFeildStyle(),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Honey Goot Change",
                                  style: Appwidget.lightTextFeildStyle(),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "NPR 210",
                                  style: Appwidget.semiBoldTextFeildStyle(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showItem() {
    return
    // scrollDirection: Axis.horizontal,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            icecream = true;
            burger = false;
            salad = false;
            pizza = false;

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: icecream ? Color(0xFFD2691E) : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/icecream.png',
                color: icecream ? Colors.black : Colors.black,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
        ),
        SizedBox(width: 15),
        GestureDetector(
          onTap: () {
            icecream = false;
            burger = false;
            salad = false;
            pizza = true;

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: pizza ? Color(0xFF8B0000) : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/pizza.png',
                color: pizza ? Colors.black : Colors.black,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
        ),
        SizedBox(width: 15),

        GestureDetector(
          onTap: () {
            icecream = false;
            burger = true;
            salad = false;
            pizza = false;

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: burger ? Color(0xFFD2A560) : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/burger.png',
                color: burger ? Colors.black : Colors.black,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
        ),
        SizedBox(width: 15),

        GestureDetector(
          onTap: () {
            icecream = false;
            burger = false;
            salad = true;
            pizza = false;

            setState(() {});
          },
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: salad ? Color(0xFF8A2BE2) : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/salad.png',
                color: salad ? Colors.black : Colors.black,
                fit: BoxFit.cover,
                height: 40,
                width: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
