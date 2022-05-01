import 'package:flutter/material.dart';
import 'package:try1/components/text_field_container.dart';
import 'package:try1/constants.dart';

class RoundedInputUsername extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final String error;
  final ValueChanged<String> onChanged;
  const RoundedInputUsername({
    Key key,
    this.error,
    this.hintText,
    this.icon = Icons.person,

    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputUsername> createState() => _RoundedInputUsernameState();
}

class _RoundedInputUsernameState extends State<RoundedInputUsername> {
  TextEditingController usernameController = TextEditingController();
  //String errorText;
  //bool validate=false;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        controller: usernameController,
        validator: (value)
        {
          if(value.isEmpty)
            return "Merci d'entrer votre pseudo";
          return null;
        },


        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
          //variable d'erreur
          errorText: widget.error,
          hintStyle: TextStyle(
            color: Colors.teal,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
