import 'package:flutter/material.dart';

class Questdetails extends StatelessWidget {
  final String currentQuest;
  final DateTime dateFound;
  final String locationFound;
  final String language;

  const Questdetails({
    super.key,
    this.currentQuest = '',
    required this.dateFound,
    this.locationFound = '',
    this.language = '',
  });

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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Word Found",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Color(0xFF999999),
                        fontFamily: 'Golos',
                      ),
                    ),
                    SizedBox(height: 3),

                    Text(
                      currentQuest,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF414141),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 4),

                    Text(
                      "Language",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Color(0xFF999999),
                        fontFamily: 'Golos',
                      ),
                    ),
                    SizedBox(height: 3),

                    Text(
                      language,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF414141),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date Found",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Color(0xFF999999),
                        fontFamily: 'Golos',
                      ),
                    ),
                    SizedBox(height: 3),

                    Text(
                      dateFound.toLocal().toString().split(' ')[0],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF414141),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 4),

                    Text(
                      "Location Found",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Color(0xFF999999),
                        fontFamily: 'Golos',
                      ),
                    ),
                    SizedBox(height: 3),

                    Text(
                      locationFound,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xFF414141),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
