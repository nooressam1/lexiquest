import 'package:flutter/material.dart';

class Statebox extends StatefulWidget {
  final String actionText;
  final String headerActionText;
  final IconData? icon; // pass an icon

  const Statebox({
    super.key,
    this.actionText = 'testing123',
    this.headerActionText = "Start new quest",
    this.icon,
  });

  @override
  State<Statebox> createState() => _StateboxState();
}

class _StateboxState extends State<Statebox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(-1, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon ?? Icons.star, // fallback if null
              color: Color(0xff9397E8),
              size: 30,
            ),
            SizedBox(height: 2),
            Text(
              widget.headerActionText,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10,
                color: Color(0xFF949494),
                fontFamily: 'Golos',
              ),
            ),
            SizedBox(height: 2),
            Text(
              widget.actionText,
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
