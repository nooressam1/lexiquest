import 'package:flutter/material.dart';
import 'package:lexiquest/Componenets/leaderboardUser.dart';
import 'package:lexiquest/Componenets/leaderboardplatform.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';
import 'package:lexiquest/Features/Account/Viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class Leaderboardpage extends StatefulWidget {
  const Leaderboardpage({super.key});

  @override
  State<Leaderboardpage> createState() => _LeaderboardpageState();
}

class _LeaderboardpageState extends State<Leaderboardpage> {
  late Future<List<Usermodel>> _usersFuture;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<Userviewmodel>(context, listen: false);
    _usersFuture = userProvider.fetchUsers(); // fetch once!
    _usersFuture.then((users) {
      print("Fetched users:");
      for (var u in users) {
        print(u.toJsonString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ----------------- HEADER -----------------
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
            gradient: const LinearGradient(
              colors: [Color(0xFF767BDE), Color(0xFFBEC1FE)],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                  width: double.infinity,
                  child: Column(
                    children: const [
                      Text(
                        "LexiQuest",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "Leaderboard",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Leaderboardplatform(rank: 2, username: "testing123"),
                    SizedBox(width: 20),
                    Leaderboardplatform(rank: 1, username: "testing123"),
                    SizedBox(width: 20),
                    Leaderboardplatform(rank: 3, username: "testing123"),
                  ],
                ),
              ],
            ),
          ),
        ),

        // ----------------- USERS LIST -----------------
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Leaderboard Users',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF414141),
                ),
              ),
              const SizedBox(height: 10),

              FutureBuilder<List<Usermodel>>(
                future: _usersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }

                  final users = snapshot.data ?? [];

                  return Column(
                    children: users.map((user) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Leaderboarduser(
                          userName: user.username,
                          userPhoto: "/images/CharacterAssets/bear.png",
                          userXp: 1200,
                          level: 1000,
                          userranking: 1,
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
