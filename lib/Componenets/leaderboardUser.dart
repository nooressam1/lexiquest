import 'package:flutter/material.dart';

class Leaderboarduser extends StatelessWidget {
  final String userName;
  final String userPhoto;
  final int userXp;
  final int level;
  final int userranking;
  const Leaderboarduser({
    super.key,
    this.userName = 'Username',
    this.userPhoto = '/images/CharacterAssets/bear.png',
    this.userXp = 1200,
    this.level = 21,
    this.userranking = 1,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  userranking.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Color(0xFF414141),
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(width: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // separates left and right
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundColor: const Color.fromARGB(
                            255,
                            95,
                            58,
                            58,
                          ),
                          backgroundImage: AssetImage(userPhoto),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xFF1E1E1E),
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              'Level $level',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                                color: Color(0xFF757575),
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
            Row(
              children: [
                Image.asset('/images/XpIcon.png', width: 20, height: 20),
                const SizedBox(width: 3),

                Text(
                  userXp.toString(),
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
      ),
    );
  }
}
