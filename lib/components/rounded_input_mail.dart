import 'package:flutter/material.dart';
import 'package:try1/components/text_field_container.dart';
import 'package:try1/constants.dart';

class RoundedInputMail extends StatefulWidget {
  final String hintText;
  final IconData icon1;
  final ValueChanged<String> onChanged;

  const RoundedInputMail({
    Key key,
    this.hintText,
    this.icon1 = Icons.mail,
    this.onChanged,
  }) : super(key: key);

  @override
  State<RoundedInputMail> createState() => _RoundedInputMailState();
}

class _RoundedInputMailState extends State<RoundedInputMail> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        controller : emailController,
        validator: (value)
        {
          if(value.isEmpty)
            return "Merci d'ajouter votre email ";
          if(!value.contains("@"))
            return "email invalide ";
          return null;
        },
        decoration: InputDecoration(
          icon: Icon(
            widget.icon1,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Colors.teal,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
