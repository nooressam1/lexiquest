import 'package:flutter/material.dart';
import 'package:lexiquest/Features/Quest/View/discoveryitempage.dart';

class Discoverybox extends StatelessWidget {
  final int questNumber;
  final String questTitle;
  final String wordFound;
  final int xpPoints;
  final String location;
  final String scannedPhoto;

  const Discoverybox({
    super.key,
    this.questNumber = 34,
    this.questTitle = "Find the word 'Light'",
    this.wordFound = "Text",
    this.xpPoints = 12,
    this.location = "testt",
    this.scannedPhoto = "",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => Discoveryitempage()));
      },
      child: Container(
        height: 150, // adjust to your needs
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 152, 151, 151).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(-1, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  color: Colors.white, // can change to transparent or gradient
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "#$questNumber",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: Color(0xff8588DE),
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            " Quest",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Color(0xFFC6C5C5),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text(
                        questTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                          color: Color(0xFF414141),
                          fontFamily: 'Inter',
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 3),

                          Text(
                            "Word Found",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                              color: Color(0xFFC6C5C5),
                              fontFamily: 'Inter',
                            ),
                          ),

                          Text(
                            wordFound,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color(0xFF414141),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 3),

                              Text(
                                "Quest Details",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: Color(0xFFC6C5C5),
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  Image.asset(
                                    '/images/XpIcon.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                  SizedBox(width: 3),

                                  Text(
                                    xpPoints.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      color: Color(0xFF414141),
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  SizedBox(width: 8),

                                  Icon(
                                    Icons.location_on,
                                    color: Color(0xff9397E8),
                                    size: 20,
                                  ),
                                  SizedBox(width: 3),

                                  Text(
                                    location,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
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
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),

                child: Image.asset(
                  scannedPhoto,
                  fit: BoxFit.cover, // fills its half nicely
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
