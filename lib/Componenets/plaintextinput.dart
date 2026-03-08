import 'package:flutter/material.dart';

class Plaintextinput extends StatefulWidget {
  final IconData iconimage;
  final String textinputtext;
  final TextEditingController textcontroller; // Add this
  final String? Function(String?)? validator;
  final bool obscureText;

  const Plaintextinput({
    super.key,
    this.iconimage = Icons.search,
    this.validator,
    required this.textinputtext,
    required this.textcontroller,
    this.obscureText = false, // default false
  });

  @override
  State<Plaintextinput> createState() => _PlaintextinputState();
}

class _PlaintextinputState extends State<Plaintextinput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textcontroller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      style: TextStyle(color: Color(0xffAEAEAE) , fontSize: 15),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.iconimage, color: Color(0xff8588DE)),
        hintText: widget.textinputtext,
        hintStyle: TextStyle(color: Color(0xffAEAEAE)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff8588DE), width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff8588DE), width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
    ;
  }
}
