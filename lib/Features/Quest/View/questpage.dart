import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/appbar.dart';
import 'package:lexiquest/Componenets/currentquests.dart';
import 'package:lexiquest/Componenets/quests.dart';
import 'package:lexiquest/Componenets/whiteButton.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Repositories/questrepository.dart';
import 'package:lexiquest/Data/Repositories/sharedpreferences.dart';
import 'package:lexiquest/Features/Quest/View/wordmatch.dart';
import 'package:lexiquest/Features/Quest/ViewModels/questviewmode.dart';
import 'package:provider/provider.dart';

class Questpage extends StatefulWidget {
  const Questpage({super.key});

  @override
  State<Questpage> createState() => _QuestpageState();
}

class _QuestpageState extends State<Questpage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<Questviewmode>(context, listen: false).loadNewQuests();
    });
  }

  @override
  Widget build(BuildContext context) {
    final questVM = Provider.of<Questviewmode>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Appbar(),

              const SizedBox(height: 20),

              // ---- CURRENT QUESTS ----
              const Text(
                'Current Quests',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF414141),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 10),

              FutureBuilder<List<Questmodel>>(
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

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quests.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      return Currentquests(
                        questId: quests[i].uid,
                        currentQuest: quests[i].questName,
                        xpPoints: quests[i].questXp,
                        lightMode: true,
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 20),

              WhiteButton(
                buttonText: "Scan Word Right Now",
                actionFunction: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).push(MaterialPageRoute(builder: (context) => Wordmatch()));
                },
              ),

              const SizedBox(height: 20),

              // ---- NEW QUESTS ----
              const Text(
                'New Quests',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF414141),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 10),

              FutureBuilder<List<Questmodel>>(
                future: () async {
                  final userId = await Sharedpreferences.getUserId();
                  if (userId == null) return <Questmodel>[];

                  return Provider.of<Questrepository>(
                    context,
                    listen: false,
                  ).fetchUserIncompleteQuests(userId);
                }(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final quests = snapshot.data!;

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quests.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (_, i) {
                      return Quests(
                        questId: quests[i].uid,
                        currentQuest: quests[i].questName,
                        xpPoints: quests[i].questXp,
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
