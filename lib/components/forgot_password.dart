import 'package:flutter/material.dart';
import 'package:try1/constants.dart';

class ForgotPassword extends StatelessWidget {
  final Function press;
  const ForgotPassword({Key key, this.press}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            "Mot de passe oublié ?",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}