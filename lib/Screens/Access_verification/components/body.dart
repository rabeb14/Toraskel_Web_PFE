import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:snippet_coder_utils/FormHelper.dart';// verification du num tel OTP
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:try1/Screens/Login/login_screen.dart';
import 'package:try1/constants.dart';
import '../../../components/already_have_an_account_check.dart';
import '../../../handler.dart';//otp service
import 'api_service.dart';
import '../otp_verify_screen.dart';//la page de verification du numéro

class Body extends StatefulWidget {
  const Body({Key key,this.numTel}):super (key: key);
  final String numTel;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //controller du numéro de telephone
  String numtelController ;

  // variable qui va contenir le num tel
  String mobileNo = '';

  //variable booléenne
  bool isAPICallProcess = false;
  Handler handler = Handler();

  @override
  Widget build(BuildContext context) {
    // This size provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    //le contenue de la page
    return Center(
      child: SingleChildScrollView(
        child: Column(
          //la position du column
          mainAxisAlignment: MainAxisAlignment.center,
          //le child possède des children
          children: <Widget>[
            Text(
              "Bienvenue !", //ecriture
              style: TextStyle(
                  fontWeight: FontWeight.bold, //font
                  color: kPrimaryColor, //couleur
                  fontSize: 30 //taille
                  ),
            ),
            //separateur
            SizedBox(height: size.height * 0.05),
            //l'image animé
            Lottie.asset(
              "assets/images/splash4.json",
              height: size.height * 0.30,
            ),
            //la distance entre
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      height: 47,
                      width: 50,
                      margin: const EdgeInsets.fromLTRB(20, 10, 3, 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color.fromRGBO(24, 125, 135, 1),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "+216",
                        style: TextStyle(
                          color: Color.fromRGBO(24, 125, 135, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                  SizedBox(width: size.height * 0.01),
                  Flexible(
                    flex: 2,
                    child: TextFormField(
                      maxLines: 1,
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Numéro de téléphone",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(24, 125, 135, 1), width: 1),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                            width: 1,
                          ),
                        ),
                      ),
                      //keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        if (value.length == 8) {
                          mobileNo = value;
                          //numtelController = TextEditingController();
                          numtelController= mobileNo ;
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Center(
              child: FormHelper.submitButton(
                "Continuer",
                () async {

                  if (mobileNo.length == 8) {

                    setState(() {
                      isAPICallProcess = true;
                    });
                    await checkNumtel();

                  }
                },
                width: 300,
                borderColor: HexColor("#78D0B1"),
                btnColor: kPrimaryColor,
                txtColor: Colors.white,
                borderRadius: 40,
              ),
            ),
            SizedBox(height: size.height * 0.01),
            /*RoundedInputNumTel(
              hintText: "Numéro de téléphone",
              onChanged: (text) {
                final _newValue = text;
                numtelController.value = TextEditingValue(
                  text: _newValue,
                  selection: TextSelection.fromPosition(
                    TextPosition(offset: _newValue.length),
                  ),
                );
              },
            ),*/
            /*RoundedButton(
              text: "Se connecter",
              textColor: kPrimaryColor,
              color: kPrimaryLightColor,
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
            ),*/
            /*RoundedButton(
              text: "Continuer",
              color: kPrimaryColor,
              textColor: Colors.white,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),*/
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
          ],
        ),
      ),
    );
  }

  checkNumtel() async {
    var response = await handler.get("/user/checkTel/${numtelController}");
    if (response['Status']) {
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            Fluttertoast.showToast(
              msg: "Vous avez déjà un compte ! ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.TOP,
              fontSize: 18,
              backgroundColor: Color.fromARGB(123, 163, 168, 172),
              textColor: Colors.black,
            );

            return LoginScreen();
          },
        ),
      );
    }
    else{
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPVerifyPage(
                  otpHash: response.data,
                  mobileNo: mobileNo,
                  reset:response.message
                ),
              ),

            );
          }
        },
      );

    }
  }

}
