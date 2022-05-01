import 'package:flutter/material.dart';
import 'package:try1/constants.dart';

class ResetCode extends StatelessWidget {
  final Function press;
  const ResetCode({Key key, this.press}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Text(
            "Renvoyer",
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
