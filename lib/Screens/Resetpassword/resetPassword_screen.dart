import 'package:flutter/material.dart';
import 'package:try1/Screens/ResetPassword/components/body.dart';

class ResetPasswordScreen extends StatelessWidget {
  const  ResetPasswordScreen ({Key key,this.numTel}):super (key: key);
  final String numTel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(numTel: numTel),
    );
  }
}
