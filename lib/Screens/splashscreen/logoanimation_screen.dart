import 'package:flutter/material.dart';
import 'package:try1/Screens/splashscreen/splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';


class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer(Duration(seconds:6), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => splashscreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff40c296),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/ToRaskel_logo.json',
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
  }