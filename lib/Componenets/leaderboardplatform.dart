import 'package:flutter/material.dart';

class Leaderboardplatform extends StatefulWidget {
  final int rank;
  final String username;

  const Leaderboardplatform({super.key, this.rank = 1, this.username = ''});

  @override
  State<Leaderboardplatform> createState() => _LeaderboardplatformState();
}

class _LeaderboardplatformState extends State<Leaderboardplatform> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              '/images/CharacterAssets/bear.png',
              width: 65,
              height: 65,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.username[0].toUpperCase() + widget.username.substring(1),

          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.white,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 3),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            color: Colors.white.withOpacity(0.6), // 50% opacity
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(
                  255,
                  152,
                  151,
                  151,
                ).withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(-1, 1),
              ),
            ],
          ),
          width: 70,
          height: 120 * (1 - (widget.rank - 1) * 0.2).clamp(0.0, 1.0),
          child: Center(
            child: Text(
              widget.rank.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
