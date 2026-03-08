import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/currentquests.dart';
import 'package:lexiquest/Componenets/descriptionbox.dart';
import 'package:lexiquest/Componenets/questdetails.dart';
import 'package:lexiquest/Componenets/whiteButton.dart';
import 'package:lexiquest/Features/Home/View/homenavigation.dart';

class Wordmatch extends StatelessWidget {
  const Wordmatch({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF767BDE), // end color
            Color(0xFFBEC1FE), // start color
          ],
          begin: Alignment.topLeft, // gradient start
          end: Alignment.topRight, // gradient end
        ),
      ),
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Column(
                children: [
                  Text(
                    'LexiQuest',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 5),

                  Text(
                    'Word Matched!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 5),

                  Text(
                    'You successfully found a  match ',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Your Quest",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 10),

                  const Currentquests(
                    currentQuest: 'Find the word “Light”',
                    xpPoints: 500,
                    difficultyLevel: 'Hard',
                    lightMode: false,
                    questId: 'quest123',
                  ),
                  SizedBox(height: 10),

                  const Text(
                    "What you discovered",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 10),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 180,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          '/images/BackgroundImagePurpleCircles.png',
                        ),
                        fit: BoxFit
                            .cover, // fills the box (like background-size: cover)
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  SizedBox(height: 14),

                  Questdetails(
                    currentQuest: 'Light',
                    locationFound: 'London, UK',
                    dateFound: DateTime.now(),
                    language: 'English',
                  ),
                  SizedBox(height: 10),

                  const Text(
                    "What you discovered",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 10),

                  Descriptionbox(
                    description:
                        'Light is the natural agent that makes things visible. It is electromagnetic radiation within a ',
                  ),
                ],
              ),
              WhiteButton(
                buttonText: 'Save Quest',
                actionFunction: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Homenavigation()),
                    (route) => false, // removes all previous routes
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
