import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/appbar.dart';
import 'package:lexiquest/Componenets/discoveryBox.dart';
import 'package:lexiquest/Componenets/gradientButton.dart';
import 'package:lexiquest/Componenets/levelprogressbar.dart';
import 'package:lexiquest/Componenets/statebox.dart';
import 'package:lexiquest/Componenets/whiteactionbox.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Repositories/questrepository.dart';
import 'package:lexiquest/Data/Repositories/sharedpreferences.dart';
import 'package:lexiquest/Features/Account/Viewmodel/userviewmodel.dart';
import 'package:lexiquest/Features/Quest/Domain/questtype.dart';
import 'package:lexiquest/Features/Quest/View/wordmatch.dart';
import 'package:provider/provider.dart';

class Homecontent extends StatelessWidget {
  const Homecontent({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userviewmodel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Appbar(),
              const SizedBox(height: 15),
              const Levelprogressbar(),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Current Quests',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color(0xFF414141),
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              // Active Quests Row
              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder<List<Questmodel>>(
                    future: () async {
                      final userId = await Sharedpreferences.getUserId();
                      if (userId == null) return <Questmodel>[];
                  
                      return Provider.of<Questrepository>(
                        context,
                        listen: false,
                      ).fetchUserActiveQuests(userId);
                    }(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                  
                      final quests = snapshot.data!;
                  
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: quests.map((quest) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Whiteactionbox(
                              actionText: quest.questName,
                              headerActionText: quest.questName,
                              actionImage: '/images/XpIcon.png',
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 15),

              GradientButton(
                buttonText: "Scan Word Right Now",
                actionFunction: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).push(MaterialPageRoute(builder: (context) => Wordmatch()));
                },
                gradientColors: [Color(0xFF8E92F6), Color(0xFFA1C6E8)],
                buttonHeight: 50,
              ),
              const SizedBox(height: 15),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Statebox(
                    actionText: "${userProvider.user?.scannedWords?.length} ",
                    headerActionText: "Words Found",
                    icon: Icons.search_sharp,
                  ),
                  const SizedBox(width: 10),
                  Statebox(
                    actionText:
                        "${userProvider.user?.languagesExplored?.length} ",
                    headerActionText: "Languages Found",
                    icon: Icons.language,
                  ),
                  const SizedBox(width: 10),
                  Statebox(
                    actionText: "24 days",
                    headerActionText: "Longest Streak ",
                    icon: Icons.leaderboard_outlined,
                  ),
                ],
              ),

              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent Discoveries',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: const Color(0xFF414141),
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 10),

              //recent discoveries list
              FutureBuilder<List<Questmodel>>(
                future: () async {
                  final userId = await Sharedpreferences.getUserId();
                  if (userId == null) return <Questmodel>[];

                  return Provider.of<Questrepository>(
                    context,
                    listen: false,
                  ).fetchUserCompletedQuests(userId);
                }(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final quests = snapshot.data!;
                  if (quests.isEmpty) {
                    return const Center(
                      child: Text(
                        "No recent discoveries yet.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 118, 118, 118),
                          fontFamily: 'Inter',
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quests.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      return Discoverybox(
                        questNumber: quests[i].questXp,
                        questTitle: quests[i].questName,
                        wordFound: quests[i].questHint,
                        xpPoints: quests[i].questXp,
                        scannedPhoto: quests[i].scannedPhoto,
                        location: quests[i].completedLocation,
                      );
                    },
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
