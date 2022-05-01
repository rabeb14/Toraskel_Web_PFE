import 'package:flutter/material.dart';
import 'package:try1/Screens/Signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key key,this.numTel}):super (key: key);
  final String numTel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(numTel: numTel),
    );
  }
}
