import 'package:flutter/material.dart';

class Currentquests extends StatelessWidget {
  final String currentQuest;
  final int xpPoints;
  final String difficultyLevel;
  final bool lightMode;
  final String questId;
  const Currentquests({
    super.key,
    required this.questId,
    this.currentQuest = '',
    this.xpPoints = 0,
    this.difficultyLevel = '',
    this.lightMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12), // optional: rounded corners
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 152, 151, 151).withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(-1, 1),
          ),
        ],
        gradient: lightMode
            ? LinearGradient(
                colors: [
                  Color(0xFF9397E8), // end color
                  Color(0xFFBEC1FE), // start color
                ],
                begin: Alignment.topLeft, // gradient start
                end: Alignment.bottomRight, // gradient end
              )
            : null,
        color: lightMode ? null : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text(
                  "Quest",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                    color: lightMode ? Color(0xFFCCCEFA) : Color(0xFF999999),
                    fontFamily: 'Inter',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Image.asset(
                      lightMode
                          ? '/images/levelWhite.png'
                          : '/images/level.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 3),

                    Text(
                      difficultyLevel,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: lightMode ? Colors.white : Color(0xFF999999),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(width: 8),

                    Image.asset(
                      lightMode
                          ? '/images/xpIconWhite.png'
                          : '/images/XpIcon.png',
                      width: 20,
                      height: 20,
                    ),
                    SizedBox(width: 3),

                    Text(
                      xpPoints.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: lightMode ? Colors.white : Color(0xFF999999),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),

            Text(
              currentQuest,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: lightMode ? Colors.white : Color(0xFF414141),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
