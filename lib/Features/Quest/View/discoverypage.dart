import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/appbar.dart';
import 'dart:math' as math;

import 'package:lexiquest/Componenets/discoveryBox.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Repositories/questrepository.dart';
import 'package:lexiquest/Data/Repositories/sharedpreferences.dart';
import 'package:lexiquest/Features/Quest/Domain/questtype.dart';
import 'package:provider/provider.dart';

class Discoverypage extends StatelessWidget {
  const Discoverypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // vertical center
            crossAxisAlignment: CrossAxisAlignment.center, // horizontal center
            children: [
              Appbar(),
              const SizedBox(height: 10),

              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          255,
                          152,
                          151,
                          151,
                        ).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(-1, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Image.asset(
                            '/images/target.png',
                            width: 70,
                            height: 70,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Check out all your discoveries",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF414141),
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              "Tap on Quests to view more details",
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
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                            "No completed quests yet.",
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
            ],
          ),
        ),
      ),
    );
  }
}
