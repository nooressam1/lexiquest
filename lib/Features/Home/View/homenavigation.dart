import 'package:flutter/material.dart';
import 'package:lexiquest/Features/Home/View/homeContent.dart';
import 'package:lexiquest/Features/Home/ViewModel/homeviewmodel.dart';
import 'package:lexiquest/Features/Account/View/accountpage.dart';
import 'package:lexiquest/Features/Quest/View/discoverypage.dart';
import 'package:lexiquest/Screens/leaderboardpage.dart';
import 'package:lexiquest/Features/Quest/View/questpage.dart';
import 'package:provider/provider.dart';

class Homenavigation extends StatefulWidget {
  const Homenavigation({super.key});

  @override
  State<Homenavigation> createState() => _HomenavigationState();
}

class _HomenavigationState extends State<Homenavigation> {
  @override
  Widget build(BuildContext context) {
    final homeVM = Provider.of<Homeviewmodel>(context);

    return Scaffold(
      body: Stack(
        children: [
          _buildOffstageNavigator(0, const Homecontent(), homeVM),
          _buildOffstageNavigator(1, const Questpage(), homeVM),
          _buildOffstageNavigator(2, const Leaderboardpage(), homeVM),
          _buildOffstageNavigator(3, const Discoverypage(), homeVM),
          _buildOffstageNavigator(4, const Accountpage(), homeVM),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeVM.currentIndex,
        onTap: homeVM.selectTab,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Quests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Discoveries',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 110, 114, 184),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildOffstageNavigator(
    int index,
    Widget child,
    Homeviewmodel homeVM,
  ) {
    return Offstage(
      offstage: homeVM.currentIndex != index,
      child: Navigator(
        key: homeVM.navigatorKeys[index],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (context) => child);
        },
      ),
    );
  }
}
