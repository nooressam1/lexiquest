import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/currentquests.dart';
import 'package:lexiquest/Componenets/levelprogressbar.dart';
import 'package:lexiquest/Componenets/statebox.dart';
import 'package:lexiquest/Componenets/whiteButton.dart';
import 'package:lexiquest/Features/Account/Domain/profilepicassets.dart';
import 'package:lexiquest/Features/Account/Viewmodel/userviewmodel.dart';
import 'package:lexiquest/Features/Account/View/editprofile.dart';
import 'package:provider/provider.dart';

class Accountpage extends StatelessWidget {
  const Accountpage({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userviewmodel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // add button
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(
                            builder: (context) => Editprofile(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ), // needed for gradient
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Color(0xffAEB1F4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Golos',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 50.0,
                backgroundColor: const Color.fromARGB(255, 95, 58, 58),
                backgroundImage: AssetImage(
                  Profilepicassets.getImage(
                    userProvider.user!.profilepicture ,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                userProvider.user?.username ?? "User",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color(0xFF1E1E1E),
                  fontFamily: 'Inter',
                ),
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Level ${userProvider.user?.userlevel ?? "0"}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Color(0xFF757575),
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset('/images/XpIcon.png', width: 25, height: 25),
                  SizedBox(width: 3),
                  const Text(
                    '1200',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Color(0xFF757575),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Statebox(
                actionText: "${userProvider.user?.leaderboardRank}",
                headerActionText: "Leaderboard Rank",
                icon: Icons.leaderboard_outlined,
              ),
              SizedBox(width: 10),

              Statebox(
                actionText: "${userProvider.user?.completedQuests?.length} ",
                headerActionText: "Words Found",
                icon: Icons.search_sharp,
              ),
              SizedBox(width: 10),

              Statebox(
                actionText: "${userProvider.user?.languagesExplored?.length} ",
                headerActionText: "Languages Found ",
                icon: Icons.language_outlined,
              ),
            ],
          ),
          const SizedBox(height: 15),

          Levelprogressbar(),
          const SizedBox(height: 15),

          Text(
            'Daily Quests ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF414141),
              fontFamily: 'Inter',
            ),
          ),
          const SizedBox(height: 15),

          Currentquests(
            currentQuest: 'Find the word “Light”',
            xpPoints: 500,
            difficultyLevel: 'Hard',
            lightMode: true,
            questId: 'quest123',
          ),
          const SizedBox(height: 15),

          WhiteButton(buttonText: "Scan Word Right Now", actionFunction: () {}),
        ],
      ),
    );
  }
}
