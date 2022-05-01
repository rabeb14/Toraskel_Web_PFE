import 'package:flutter/material.dart';
import 'package:try1/components/text_field_container.dart';
import 'package:try1/constants.dart';

class RoundedLoginPassword extends StatefulWidget { 
  final ValueChanged<String> onChanged;
  final String error;
  final String hintText;

  const RoundedLoginPassword({
    Key key,
    this.onChanged,
    this.error,
    this.hintText,

  }) : super(key: key);

  @override
  State<RoundedLoginPassword> createState() => _RoundedLoginPasswordState();
}

class _RoundedLoginPasswordState extends State<RoundedLoginPassword> {
  bool vis =true;
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
       obscureText: vis,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        controller: passwordController,
        validator: (value)
        {
        if(value.isEmpty)
          {return "Merci d'entrer votre mot de passe";}
        return null;
        },
        decoration: InputDecoration(
          errorText: widget.error,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.teal),
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon:Icon(vis? Icons.visibility_off:Icons.visibility),
            onPressed: () {
              setState(() {
                vis = !vis;
              });
            },

            color: kPrimaryColor,


          ),

          border: InputBorder.none,
        ),
      ),
    );
  }
}
