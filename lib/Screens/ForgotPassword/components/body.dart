import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:try1/Screens/ForgotPassword/components/otp_verify_page.dart';
import 'package:try1/Screens/Access_verification/access_verification_screen.dart';
import 'package:try1/components/rounded_button.dart';
import 'package:try1/components/rounded_input_numtel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../handler.dart';
import '../../Access_verification/components/api_service.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.numTel}) : super(key: key);
  final String numTel;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //variable global
  final _globalkey = GlobalKey<FormState>();

  //instance de la classe Handler
  Handler handler = Handler();
  String errorText;
  bool circular = false;
  bool validate = false;

  //controllers
  String numController;

  bool isAPICallProcess;
  String mobileNo = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _globalkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Lottie.asset(
                "assets/images/screen6.json",
                height: size.height * 0.30,
              ),
              SizedBox(height: size.height * 0.008),
              Text(
                "Mot de passe oublié",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(48, 180, 168, 100),
                  fontSize: 30,
                ),
              ),
              SizedBox(height: size.height * 0.008),
              SizedBox(height: 30),
              RoundedInputNumTel(
                hintText: "Numéro de téléphone",
                error: validate ? null : errorText,
                onChanged: (String value) {
                  if (value.length == 8) {
                    mobileNo = value;
                    //numtelController = TextEditingController();
                    numController = mobileNo; //get le numéro de tel
                  }
                },
              ),
              circular
                  ? CircularProgressIndicator()
                  : RoundedButton(
                      text: "Envoyer",
                      press: () async {
                        if (mobileNo.length == 8) {
                          setState(() {
                            isAPICallProcess = true;
                          });
                          await checkNumtel(); //verifier le numéro et retourner le code + envoyer a la page otp verify
                        }
                      }),
              SizedBox(height: size.height * 0.03),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 40, 0),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 70,
                  width: 600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  checkNumtel() async {
    var response = await handler.get("/user/checkTel/${numController}");
    if (response['Status']) {
      //setState(() {});
      APIService.otpLogin(mobileNo).then(
        (response) async {
          setState(() {
            isAPICallProcess = false;
          });
          Fluttertoast.showToast(
            msg: response.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            fontSize: 18,
            backgroundColor: Color.fromARGB(123, 163, 168, 172),
            textColor: Colors.black,
          );
          print(response.message);
          print(response.data);

          if (response.data != null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => OTPVerifyForgotPage(
                  otpHash: response.data,
                  mobileNo: mobileNo,
                ),
              ),
              (route) => false,
            );
          }
        },
      );
    } else {
      Fluttertoast.showToast(
        msg: "Numéro de téléphone inexistant ",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        fontSize: 18,
        backgroundColor: Color.fromARGB(123, 163, 168, 172),
        textColor: Colors.black,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => AccessVerificationScreen(),
        ),
        (route) => false,
      );
    }
  }
}
