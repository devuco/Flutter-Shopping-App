import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/utils/Utils.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  List<dynamic> buttons = [
    {"label": 'Home', "icon": Icons.home},
    {"label": 'Categories', "icon": Icons.category},
    {"label": 'Brands', "icon": Icons.branding_watermark},
    {"label": 'Wishlist', "icon": Icons.menu}
  ];

  List<Widget> pages = [
    const Home(),
    const Login(),
    const Login(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        backgroundColor: Colors.orange,
        child: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.orange),
                  child: CircleAvatar(
                    foregroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                ),
                Logout()
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: index,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          color: Colors.white,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buttons.asMap().entries.map((e) {
                int i = e.key;
                final item = e.value;
                bool isSelected = index == i;
                return GestureDetector(
                  onTap: () {
                    if (i == 3) {
                      scaffoldKey.currentState?.openEndDrawer();
                    } else {
                      setState(() => index = i);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: isSelected
                            ? Utils.getColor('#fcf0e7')
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Icon(
                            item["icon"],
                            size: 28,
                            color: isSelected
                                ? Utils.getColor('#f26b27')
                                : Colors.grey[400],
                          ),
                        ),
                        if (isSelected)
                          Text(
                            item["label"],
                            style: TextStyle(
                                color: Utils.getColor('#f26b27'),
                                fontWeight: FontWeight.w600),
                          )
                      ],
                    ),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GetStorage().erase();
        Get.offAll(const Login());
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: const [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.logout,
                color: Colors.orange,
              ),
            ),
            Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
