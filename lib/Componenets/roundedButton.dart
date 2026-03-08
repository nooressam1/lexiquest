import 'package:flutter/material.dart';

class Roundedbutton extends StatelessWidget {
  final String text;
  final bool isFilled;
  final VoidCallback onPressed;

  const Roundedbutton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFilled = true, // default = filled
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isFilled
              ? Colors.white
              : Colors.transparent, // filled or not
          side: BorderSide(color: Colors.white, width: 1),
          foregroundColor: isFilled
              ? Color(0xffAEB1F4)
              : Colors.white, // text color
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadowColor: Colors.transparent, // removes shadow
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: "Golos",
          ),
        ),
      ),
    );
  }
}
