import 'package:flutter/material.dart';
import 'package:lexiquest/Features/Account/Viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';

class Levelprogressbar extends StatefulWidget {
  const Levelprogressbar({super.key});

  @override
  State<Levelprogressbar> createState() => _LevelprogressbarState();
}

class _LevelprogressbarState extends State<Levelprogressbar> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userviewmodel>(context);

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 100,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('images/BackgroundImagePurpleCircles.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Level ${userProvider.user?.userlevel ?? 0}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Color.fromARGB(255, 248, 248, 248),
                  fontFamily: 'Golos',
                ),
              ),
              const Text(
                "Keep going, you're almost there!",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: Color.fromARGB(255, 248, 248, 248),
                  fontFamily: 'Golos',
                ),
              ),
              const SizedBox(height: 10),

              FutureBuilder<double>(
                future: userProvider.calculateProgressBarXp(),
                builder: (context, snapshot) {
                  final progress = snapshot.data ?? 0.0;
                  print('Progress value: $progress');
                  return SizedBox(
                    width: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress, // from 0.0 to 1.0
                        minHeight: 12,
                        backgroundColor: Colors.white,
                        color: const Color(0xFF8D90F4),
                      ),
                    ),
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
