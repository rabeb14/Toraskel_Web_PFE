import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:try1/Screens/Access_verification/access_verification_screen.dart';
import '../../components/already_have_an_account_check.dart';
import '../../components/resendCode.dart';
import '../Signup/signup_screen.dart';
import 'components/api_service.dart';
import 'components/config.dart';

class OTPVerifyPage extends StatefulWidget {
  final String mobileNo;
  final String otpHash;
  final String reset;

  OTPVerifyPage({this.mobileNo, this.otpHash, this.reset});

  @override
  _OTPVerifyPageState createState() => _OTPVerifyPageState();
}

class _OTPVerifyPageState extends State<OTPVerifyPage> {
  bool enableResendBtn = false;
  String _otpCode = "";
  final int _otpCodeLength = 4;

  //bool _enableButton = false;

  //var autoFill;
  FocusNode myFocusNode;
  bool isAPIcallProcess = false;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.requestFocus();

    // SmsAutoFill().listenForCode;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ProgressHUD(
          child: otpVerify(),
          inAsyncCall: false,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget otpVerify() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset("assets/images/splash5.json"),
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Text(
              "OTP Verification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Text(
            "Merci d'écrire le code qu'on vous a fournit \n+216 ${widget.mobileNo}",
            maxLines: 2,
            style: const TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          //child: autoFill,
          child: PinFieldAutoFill(
            decoration: UnderlineDecoration(
              textStyle: const TextStyle(fontSize: 20, color: Colors.black),
              colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
            ),
            keyboardType: TextInputType.text,
            currentCode: _otpCode,
            codeLength: _otpCodeLength,
            // onCodeSubmitted: (code) {},

            //-------------------------------------------------------------
            onCodeChanged: (code) {
              print(code);
              if (code.length == _otpCodeLength) {
                _otpCode = code;
                //_enableButton = true;
                // FocusScope.of(context).requestFocus(FocusNode());
              }

              //-------------------------------------------------------------------
            },
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: FormHelper.submitButton(
            "Verifier",
            () {
              setState(() {
                isAPIcallProcess = true;
              });
              //ken el code mahouch vide
              if (_otpCode != "") {
                APIService.verifyOtp(widget.mobileNo, widget.otpHash, _otpCode)
                    .then((response) {
                  setState(() {
                    isAPIcallProcess = false;
                    //print(response.data);
                  });
                  //ken el verify raj3et success ya3ni el code shih
                  if (response.data == "Success") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(numTel: widget.mobileNo),
                        ),
                        (route) => false);
                    //ken raj3et invalid otp ya3ni el code ghalet
                  } else if (response.data == "Invalid OTP") {
                    //print(response.data);
                    setState(() {
                      _otpCode = "";
                    });
                    Fluttertoast.showToast(
                      msg: "Code incorrecte ! ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      fontSize: 18,
                      backgroundColor: Color.fromARGB(123, 163, 168, 172),
                      textColor: Colors.black,
                    );
                    // Navigator.pop(context);
                  }
                });
              }
              //ken el code vide
              else {
                Fluttertoast.showToast(
                  msg: "Merci d'insérer le code  ! ",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  fontSize: 18,
                  backgroundColor: Color.fromARGB(123, 163, 168, 172),
                  textColor: Colors.black,
                );
                setState(() {});
              }
            },
            btnColor: HexColor("#78D0B1"),
            borderColor: HexColor("#78D0B1"),
            txtColor: Colors.white,
            borderRadius: 20,
          ),
        ),
        ResetCode(
          press: () {
            APIService.otpLogin(widget.mobileNo).then(
              (response) async {
                setState(() {
                  //isAPICallProcess = false;
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
              },
            );
          },
        ),
      ],
    );
  }
}

@override
void dispose() {
  SmsAutoFill().unregisterListener();
  // myFocusNode.dispose();
  //super.dispose();
}

class CodeAutoFillTestPage extends StatefulWidget {
  @override
  _CodeAutoFillTestPageState createState() => _CodeAutoFillTestPageState();
}

class _CodeAutoFillTestPageState extends State<CodeAutoFillTestPage>
    with CodeAutoFill {
  String appSignature;
  String otpCode;

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code;
    });
  }

  @override
  void initState() {
    super.initState();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    cancel();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 18);

    return
    new Scaffold(
      appBar: AppBar(
        title: Text("Listening for code"),
        leading: new IconButton(
          icon: new Icon(Icons.ac_unit),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              "This is the current app signature: $appSignature",
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Builder(
              builder: (_) {
                if (otpCode == null) {
                  return Text("Listening for code...", style: textStyle);
                }
                return Text("Code Received: $otpCode", style: textStyle);
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );


  }
}
