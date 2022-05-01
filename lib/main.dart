import 'package:flutter/material.dart';
import 'package:try1/Screens/Access_verification/access_verification_screen.dart';
import 'package:try1/constants.dart';

import 'Screens/accueil/accueil_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Accueil_screen(),
    );
  }
}