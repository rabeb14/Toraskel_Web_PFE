import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:try1/Screens/ForgotPassword/ForgotPassword_screen.dart';
import 'package:try1/Screens/Access_verification/access_verification_screen.dart';
import 'package:try1/components/already_have_an_account_check.dart';
import 'package:try1/components/rounded_button.dart';
import 'package:try1/components/rounded_input_username.dart';
import 'package:try1/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:try1/components/forgot_password.dart';
import 'package:try1/components/rounded_login_password.dart';
import '../../../handler.dart';
import '../../accueil/accueil_screen.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);


  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //variable global
  final _globalkey= GlobalKey<FormState>();
  //instance de la classe Handler
  Handler handler=Handler();
  String errorText;
  bool circular=false;
  bool validate=false;
  //controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // ignore: prefer_const_constructors
            Text(
              "Se connecter",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
                fontSize: 30,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.01),
            RoundedInputUsername(
              hintText: "Pseudo",
              error: validate?null:errorText,
              onChanged: (text)
              {
                final _newValue = text;
                usernameController.value = TextEditingValue
                  (
                  text: _newValue,
                  selection: TextSelection.fromPosition
                    (
                    TextPosition(offset: _newValue.length),
                  ),
                );
              },
            ),
            RoundedLoginPassword(
              hintText:"Mot de passe",
              error: validate?null:errorText,
              onChanged: (text)
              {
                final _newValue = text;
                passwordController.value = TextEditingValue
                  (
                  text: _newValue,
                  selection: TextSelection.fromPosition
                    (
                    TextPosition(offset: _newValue.length),
                  ),
                );
              },
            ),
            circular?CircularProgressIndicator():
            RoundedButton(
              text: "Se connecter",
              press: () async
              {
                setState(() {
                  circular = true;
                });
                Map<String,String> data=
                {
                  "username":usernameController.text,
                  "password":passwordController.text,
                };
                var response = await handler.post("/user/login", data);
                if (response.statusCode == 200 || response.statusCode==201)
                {
                  Map<String,dynamic> output = json.decode(response.body);
                  print(output['token']);
                  setState(() {
                    validate=true;
                    circular = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Accueil_screen ();

                      },
                    ),
                  );
                }
                else{
                  String output = json.decode(response.body);
                  setState(() {
                    validate=false;
                    errorText= output;
                    circular = false;

                  });
                }
              },
            ),
            SizedBox(height: size.height * 0.01),
            ForgotPassword(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ForgotPasswordScreen();

                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.01),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AccessVerificationScreen();
                    },
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 40, 0),
              child: Image.asset("assets/images/logo.png",height: 50,width:100 ,),
            ),

          ],
        ),
      ),
    );

  }

}
