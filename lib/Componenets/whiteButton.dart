import 'package:flutter/material.dart';

class WhiteButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback actionFunction;

  const WhiteButton({
    super.key,
    this.buttonText = "Click Me",
    required this.actionFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
            color: const Color.fromARGB(255, 152, 151, 151).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(-1, 1),
          ),
          ],
        ),
        child: TextButton(
          onPressed: actionFunction,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF414141),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Color(0xFF414141),
              fontWeight: FontWeight.w600,
              fontFamily: 'Golos',
            ),
          ),
        ),
      ),
    );
  }
}
