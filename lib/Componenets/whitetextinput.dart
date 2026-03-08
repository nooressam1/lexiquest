import 'package:flutter/material.dart';

class Whitetextinput extends StatelessWidget {
  final IconData iconimage;
  final String textinputtext;
  final TextEditingController textcontroller; // Add this
  final String? Function(String?)? validator;
  final bool obscureText;

  const Whitetextinput({
    super.key,
    this.iconimage = Icons.search,
    this.validator,
    required this.textinputtext,
    required this.textcontroller,
    this.obscureText = false, // default false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textcontroller,
      validator: validator,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(iconimage, color: Colors.white),
        hintText: textinputtext,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
