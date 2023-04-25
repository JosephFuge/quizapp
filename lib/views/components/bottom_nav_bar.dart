import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/routes.dart';

const iconSize = 20.0;

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.graduationCap, size: iconSize),
            label: 'Topics',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.bolt, size: iconSize),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.circleUser, size: iconSize),
            label: 'Profile',
          )
        ],
        fixedColor: Colors.deepPurple[200],
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.pushNamed(context, QuizRoutes.aboutPage);
              break;
            case 2:
              Navigator.pushNamed(context, QuizRoutes.profilePage);
              break;
          }
        });
  }
}
