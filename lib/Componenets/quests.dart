import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/gradientButton.dart';
import 'package:lexiquest/Features/Quest/View/wordmatch.dart';
import 'package:lexiquest/Features/Quest/ViewModels/questviewmode.dart';
import 'package:provider/provider.dart';

class Quests extends StatelessWidget {
  final String currentQuest;
  final int xpPoints;
  final String difficultyLevel;
  final String questId;
  const Quests({
    super.key,
    required this.questId,
    this.currentQuest = '',
    this.xpPoints = 0,
    this.difficultyLevel = '',
  });

  @override
  Widget build(BuildContext context) {
    final questVM = Provider.of<Questviewmode>(context);

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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Quest hint",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Color(0xFF757575),
                      fontFamily: 'Inter',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Image.asset('/images/level.png', width: 20, height: 20),
                      SizedBox(width: 3),

                      Text(
                        difficultyLevel,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color(0xFF414141),
                          fontFamily: 'Inter',
                        ),
                      ),
                      SizedBox(width: 8),

                      Image.asset('/images/XpIcon.png', width: 20, height: 20),
                      SizedBox(width: 3),

                      Text(
                        xpPoints.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Color(0xFF414141),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 1.0,
                horizontal: 8.0,
              ),
              child: Text(
                currentQuest,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF414141),
                  fontFamily: 'Inter',
                ),
              ),
            ),
            SizedBox(height: 10),
            GradientButton(
              buttonText: "Start Quest",
              actionFunction: () {
                questVM.activateQuest(questId);
              },
              buttonHeight: 40,
              gradientColors: [Color(0xFF8E92F6), Color(0xFFA1C6E8)],
            ),
          ],
        ),
      ),
    );
  }
}
