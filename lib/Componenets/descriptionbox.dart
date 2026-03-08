import 'package:flutter/material.dart';

class Descriptionbox extends StatelessWidget {
  final String description;
  const Descriptionbox({super.key, this.description = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12), // optional: rounded corners
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
                color: Color(0xFF999999),
                fontFamily: 'Inter',
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Color(0xFF414141),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
