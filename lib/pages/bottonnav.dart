import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:food/pages/homescreen.dart';
import 'package:food/pages/order.dart';
import 'package:food/pages/profile.dart';
import 'package:food/pages/wallet.dart';

class Bottonnav extends StatefulWidget {
  const Bottonnav({super.key});

  @override
  State<Bottonnav> createState() => _BottonnavState();
}

class _BottonnavState extends State<Bottonnav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;

  late Home homepage;
  late Profile profile;
  late Wallet wallet;
  late Order order;

  @override
  void initState() {
    super.initState();
    homepage = Home();
    order = Order();
    wallet = Wallet();
    profile = Profile();
    pages = [homepage, order, wallet, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
        height: 65,
        backgroundColor: Colors.black,
        color: Colors.white,
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.shopping_bag_outlined, title: 'order'),
          TabItem(icon: Icons.wallet, title: 'wallet'),
          TabItem(icon: Icons.person_2_outlined, title: 'person'),
        ],
      ),
      body: pages[currentTabIndex],
    );
  }
}
