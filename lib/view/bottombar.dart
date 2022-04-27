import 'package:flutter/material.dart';
import 'package:task_1/view/update_profile.dart';

import 'homescreen.dart';
import 'notification.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int bottomint = 0;
  List<dynamic> listPage = [
    HomeScreen(),
    NotificationDemo(),
    NotificationDemo(),
    NotificationDemo(),
    UpdateProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listPage[bottomint],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomint,
        onTap: (value) {
          setState(() {
            bottomint = value;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blueGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Book"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notification"),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: "Profile")
        ],
      ),
    );
  }
}
