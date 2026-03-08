import 'package:flutter/material.dart';

class Onboardingpage extends StatelessWidget {
  const Onboardingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF3BFEB), // light pink (top)
              Color(0xFFAEB1F4), // purple (middle)
              Color(0xFFAEB1F4), // purple (middle)
              Color(0xFFAEB1F4), // purple (middle)

              Color(0xFFF1D5ED), // light pink (bottom)
            ],
            stops: [0.0, 0.4, 0.5, 0.6, 1.0], // controls where each color appears
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'LexiQuest',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Golos',
                  color: Colors.white,
                ),
              ),
              Text(
                'One Quest One Word',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Golos',
                  fontWeight: FontWeight.w400,
                  color: Color(0xffF4F0FF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
