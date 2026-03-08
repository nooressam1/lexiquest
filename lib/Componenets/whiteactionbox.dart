import 'package:flutter/material.dart';

class Whiteactionbox extends StatelessWidget {
  final String actionText;
  final String headerActionText;
  final String actionImage;

  const Whiteactionbox({
    super.key,
    this.actionText = 'Find a sign with the word ', // default main text
    this.headerActionText = "Start new quest", // default header
    this.actionImage = '/images/default.png', // placeholder image
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.43,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 152, 151, 151).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(-1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(actionImage, width: 65, height: 65),
            SizedBox(height: 5),

            Text(
              headerActionText,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
                color: Color(0xFF949494),
                fontFamily: 'Golos',
              ),
            ),
            SizedBox(height: 2),
            Text(
              actionText,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color(0xFF414141),
                fontFamily: 'Golos',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
