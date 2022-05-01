import 'package:flutter/material.dart';
import 'package:try1/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;

  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? " Vous n'avez pas de compte ? " : " Avez vous déjà un compte ? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "S'inscrire" : "Se connecter",
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

//si login =true : Vous n'avez pas de compte  sinon Avez vous déjà un compte
//si login =true : s'inscrire  sinon se connecter