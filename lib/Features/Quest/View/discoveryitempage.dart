import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/currentquests.dart';
import 'package:lexiquest/Componenets/descriptionbox.dart';
import 'package:lexiquest/Componenets/questdetails.dart';
import 'package:lexiquest/Features/Quest/View/discoverypage.dart';

class Discoveryitempage extends StatelessWidget {
  const Discoveryitempage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30.0,
                left: 20,
                right: 20,
                // bottom: 15,
              ),
              child: Stack(
                children: [
                  // Centered Texts
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF414141),
                            ),
                            children: [
                              TextSpan(
                                text: 'LexiQuest\n',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                  fontSize: 15,
                                ),
                              ),
                              TextSpan(
                                text: 'Discovery #32',

                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Left-aligned Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff9397E8),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2,
                            offset: const Offset(1, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Discoverypage(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        '/images/BackgroundImagePurpleCircles.png',
                      ),
                      fit: BoxFit
                          .cover, // fills the box (like background-size: cover)
                    ),
                  ),
                ),
                Positioned(
                  bottom: -40, // pushes it downward to overlap
                  left: 20,
                  right: 20,
                  child: Currentquests(
                    currentQuest: 'Find the word “Light”',
                    xpPoints: 500,
                    difficultyLevel: 'Hard',
                    lightMode: false,
                    questId: 'quest123',
                  ),
                ),
              ],
            ),

            SizedBox(height: 50),

            Questdetails(
              currentQuest: 'Light',
              locationFound: 'London, UK',
              dateFound: DateTime.now(),
              language: 'English',
            ),
            SizedBox(height: 10),

            Descriptionbox(
              description:
                  'Light is the natural agent that makes things visible. It is electromagnetic radiation within a ',
            ),
          ],
        ),
      ),
    );
  }
}
