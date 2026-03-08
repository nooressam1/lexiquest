import 'package:flutter/material.dart';

class Splashscreens extends StatefulWidget {
  const Splashscreens({super.key});

  @override
  State<Splashscreens> createState() => _SplashscreensState();
}

class _SplashscreensState extends State<Splashscreens> {
  List<IconData> iconsData = [
    Icons.camera_alt,
    Icons.image_outlined,
    Icons.leaderboard_outlined,
  ];
  List<String> headerText = [
    "Scan the World",
    "Track your adventures",
    "Compete with everyone",
  ];
  List<String> subheaderText = [
    "Use your camera to spot and capture words in your surroundings",
    "Complete quests and save your adventures to later revisit",
    "Gain points from completing quests and rise on the leaderboard",
  ];

  int currentIndex = 0;
  void nextPage() {
    setState(() {
      if (currentIndex < headerText.length - 1) {
        currentIndex++;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3BFEB), // light pink (top)
              Color(0xFFAEB1F4), // purple (middle)
              Color(0xFFAEB1F4), Color(0xFFAEB1F4),
              Color(0xFFF1D5ED), // light pink (bottom)
            ],
            stops: [0.0, 0.4, 0.5, 0.6, 1.0],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.7,
              child: Stack(
                clipBehavior: Clip.none, // allow overflow
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: screenWidth * 1.5,
                      height: screenHeight * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(screenWidth),
                          bottomRight: Radius.circular(screenWidth),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      'LexiQuest',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Golos',
                        color: Colors.white,
                      ),
                    ),
                  ), // Camera icon
                  Container(
                    width: 500,
                    height: 500,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Camera icon
                        Positioned(
                          top: 230,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            transitionBuilder: (child, animation) =>
                                FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                            child: Icon(
                              iconsData[currentIndex],
                              key: ValueKey(
                                iconsData[currentIndex],
                              ), // important
                              color: Colors.white,
                              size: 258,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 420, // adjust this to control how close it is
                          child: Container(
                            width: 328,
                            height: 68,
                            decoration: ShapeDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: OvalBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250,
              width: 320,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        headerText[currentIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Golos',
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text(
                        subheaderText[currentIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Golos',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        // navigate to different page
                        child: Text(
                          "Skip",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Golos',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                      Container(
                        width: 55,
                        height: 5,
                        decoration: BoxDecoration(
                          color: currentIndex == 0
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 55,
                        height: 5,
                        decoration: BoxDecoration(
                          color: currentIndex == 1
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 55,
                        height: 5,
                        decoration: BoxDecoration(
                          color: currentIndex == 2
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 25),
                      GestureDetector(
                        onTap: nextPage,
                        child: Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Golos',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
