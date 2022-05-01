import 'package:flutter/material.dart';
import 'package:try1/Screens/Login/login_screen.dart';
import 'package:try1/components/rounded_button.dart';
import 'package:try1/constants.dart';
import 'package:try1/components/rounded_login_password.dart';
import '../../../handler.dart';

class Body extends StatefulWidget {

  const Body({Key key,this.numTel}):super (key: key);
  final String numTel;
  
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
  //String numtel='';
  //controllers
String numController;
  TextEditingController passwordController = TextEditingController();
  TextEditingController ConfirmPasswordController = TextEditingController();

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
              "Mise à jour du mot de passe",
              // ignore: prefer_const_constructors
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 30,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            /*RoundedInputUsername(
              hintText: "Pseudo",
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
                 ),*/
             RoundedLoginPassword(
              hintText:"Nouveau mot de passe",
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
              RoundedLoginPassword(
              hintText:"Confirmer mot de passe",
              error: validate?null:errorText,
              onChanged: (text)
                {
                  final _newValue = text;
                  ConfirmPasswordController.value = TextEditingValue
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
              text: "Mettre à jour",
              press: () async
                  {
                    setState
                    (()
                    {
                      circular =true;
                    }
                    );
                    await checkPassword();
                    if(validate)
                    {
                    
                      Map<String, String> data = {
                        "password": passwordController.text,
                        "num_tel":widget.numTel,
                      };
                      print("/user/update/${widget.numTel}");
                      var response = await handler.patch(
                          "/user/update/${widget.numTel}", data);

                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        print("/user/update/${widget.numTel}");
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      }
                    }
                    else
                    {
                      setState
                      (()
                      {
                        circular=false;
                      }
                      );
                    }
                  },
             ),
          ],
        ),
      ),
    );
  }
    checkPassword()async
    {
      if(passwordController.text.length==0){
        setState((){
          circular=false;
          validate=false;
          errorText="Merci d'entrer un nouveau mot de passe ";
        });
      }
      else{
          if (ConfirmPasswordController.text.length==0)
            {
              setState((){
                circular=false;
                validate=false;
                errorText="Merci de confirmer votre mot de passe";
              });
            }
          else{
            if (ConfirmPasswordController.text != passwordController.text)
              {
                setState((){
                  circular=false;
                  validate=false;
                  errorText="Les mots de passe ne correspondent pas";
                });
              }
            else{
                setState(() {
                  validate=true;
                });
            }
          }
      }

    }

  }
