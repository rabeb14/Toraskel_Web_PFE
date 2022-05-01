import 'package:flutter/material.dart';
import 'package:try1/components/text_field_container.dart';
import 'package:try1/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
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
            return "Merci d'entrer votre mot de passe  ";
          if(value.length<=8)
            return "Merci d'entrer plus que 8 caractère ";
          //username unique ou non
          return null;
        },
        decoration: InputDecoration(
          hintText: "Mot de passe",
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
