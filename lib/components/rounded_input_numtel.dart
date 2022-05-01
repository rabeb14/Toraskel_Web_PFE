import 'package:flutter/material.dart';
import 'package:try1/components/text_field_container.dart';
import 'package:try1/constants.dart';

class RoundedInputNumTel extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final String error;
  final ValueChanged<String> onChanged;
  const RoundedInputNumTel({
    Key key,
    this.error,
    this.hintText,
    this.icon = Icons.person,

    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputNumTel> createState() => _RoundedInputNumTelState();
}

class _RoundedInputNumTelState extends State<RoundedInputNumTel> {
  TextEditingController numController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        controller: numController,

        validator: (value)
        {
          Pattern pattern =
              r'/^\(?(\d{3})\)?[- ]?(\d{3})[- ]?(\d{4})$/';
          RegExp regex = new RegExp(pattern);
          if(value.isEmpty)
            return "Merci d'ajouter votre numéro de téléphone ";
          if((value.length!=8 )&&(!regex.hasMatch(value)))
            return "Merci d'entrer le numéro correcte";
          //username unique ou non
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(
            Icons.phone,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
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
