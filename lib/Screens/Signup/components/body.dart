import 'package:flutter/material.dart';
import 'package:try1/Screens/Login/login_screen.dart';
import 'package:try1/Screens/accueil/accueil_screen.dart';
import 'package:try1/components/already_have_an_account_check.dart';
import 'package:try1/components/rounded_button.dart';
import 'package:try1/components/rounded_input_mail.dart';
import 'package:try1/components/rounded_input_username.dart';
import 'package:try1/components/rounded_password_field.dart';
import '../../../handler.dart';



class Body extends StatefulWidget {
  const Body({Key key,this.numTel}):super (key: key);
  final String numTel;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //variable global
  final _globalkey= GlobalKey<FormState>();
  //instance de la classe Handler
  Handler handler=Handler();
  //
  String errorText;
  bool circular=false;
  bool validate=false;
  //controllers
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    //size of screen
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key:_globalkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.008),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 40, 10),
                child: Image.asset("assets/images/logo.png",height: 200,width:300 ,),
              ),
             // SizedBox(height: size.height * 0.01),
              Text
                ("S'inscrire",
                style: TextStyle
                  (
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(48,180,168,100),
                    fontSize: 30,
                  ),
                ),
              SizedBox(height: size.height * 0.008),

             SizedBox(height:30),
              //input username
              RoundedInputUsername
                (
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

              RoundedInputMail
                (
                hintText: "Email",
                onChanged: (text)
                {
                  final _newValue = text;
                  emailController.value = TextEditingValue
                    (
                    text: _newValue,
                    selection: TextSelection.fromPosition
                      (
                      TextPosition(offset: _newValue.length),
                      ),
                    );
                 },
                 ),
              RoundedPasswordField
                (
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
              RoundedButton
                (
                  text: "S'inscrire",
                  press: () async
                  {
                    setState
                    (()
                    {
                      circular =true;
                    }
                    );
                    await checkUser();

                    if(_globalkey.currentState.validate() && validate)
                    {
                      Map<String,String>data=
                      {
                        "username":usernameController.text,
                        "email":emailController.text,
                        "num_tel":widget.numTel,
                        "password":passwordController.text,
                      };
                      print(data);
                      await handler.post("/user/register",data);
                      setState
                      (()
                      {
                        circular=false;
                      }
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Accueil_screen();
                          },
                        ),
                      );
                      //handler.get("");
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

              SizedBox(height: size.height * 0.01),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: size.height * 0.03),
              //OrDivider(),
              SizedBox(height: size.height * 0.02),

            ],
          ),
        ),
      ),
    );
  }
  checkUser()async{
    if(usernameController.text.length==0){
      setState((){
        circular=false;
        validate=false;
        errorText="Merci d'ajouter un pseudo ";
      });
    }
    else{
      var response = await handler.get("/user/checkusername/${usernameController.text}");
      if (response ['Status'])
        {
          setState((){
            circular=false;
            validate=false;
            errorText="Ce pseudo existe déja  ";
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

