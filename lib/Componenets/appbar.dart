import 'package:flutter/material.dart';
import 'package:lexiquest/Features/Account/Viewmodel/userviewmodel.dart';
import 'package:provider/provider.dart';
import 'package:lexiquest/Features/Account/Domain/profilepicassets.dart';

class Appbar extends StatefulWidget {
  const Appbar({super.key});

  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<Userviewmodel>(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 25.0,
                    backgroundColor: const Color.fromARGB(255, 95, 58, 58),
                    backgroundImage: AssetImage(
                      Profilepicassets.getImage(
                        userProvider.user!.profilepicture,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userProvider.user?.username ?? "User",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1E1E1E),
                        fontFamily: 'Inter',
                      ),
                    ),
                    Text(
                      'Level ${userProvider.user?.userlevel ?? "0"}',
                      style: const TextStyle(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffF1F0F8), width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    Image.asset('/images/XpIcon.png', width: 25, height: 25),
                    const SizedBox(width: 3),
                    const Text(
                      '1200',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF414141),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
