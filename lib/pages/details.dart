import 'package:flutter/material.dart';
import 'package:food/widget/widget_support.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int a = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 45.0, left: 20.0, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),

            Material(
              elevation: 8.0,
              child: Image.asset(
                "images/salad2.jpg",
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mediteranean",
                      style: Appwidget.semiBoldTextFeildStyle(),
                    ),
                    Text(
                      "Chickpea Salad",
                      style: Appwidget.boldTextFeildStyle(),
                    ),
                  ],
                ),
                Spacer(),

                GestureDetector(
                  onTap: () {
                    if (a > 1) {
                      a--;
                    }
                    setState(() {});
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                Text(a.toString(), style: Appwidget.boldTextFeildStyle()),
                SizedBox(width: 20),

                GestureDetector(
                  onTap: () {
                    a++;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              maxLines: 3,
              style: Appwidget.lightTextFeildStyle(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(height: 25),

                Text("Delivery Time", style: Appwidget.boldTextFeildStyle()),
                SizedBox(width: 20),
                Icon(Icons.alarm, color: Colors.black),

                Text("30 min", style: Appwidget.boldTextFeildStyle()),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: Appwidget.headlineTextFeildStyle(),
                      ),
                      Text(
                        "NPR 250",
                        style: Appwidget.semiBoldTextFeildStyle(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Add To Cart",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: "Puffins",
                        ),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.shopping_cart, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
