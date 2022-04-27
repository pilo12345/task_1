import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/view/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Get.to(RegisterScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: const [Colors.white, Colors.blueAccent])),
          child: Center(
            child: Image(
              image: AssetImage("assets/image/03.png"),
            ),
          ),
        ),
      ),
    );
  }
}
