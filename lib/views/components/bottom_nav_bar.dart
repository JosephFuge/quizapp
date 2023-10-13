import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const iconSize = 20.0;

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({required this.changePage, this.currentPage = 0, super.key});
  final Function changePage;
  final int currentPage;

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
        currentIndex: currentPage,
        selectedItemColor: Colors.deepPurple[200],
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          changePage(index);
        });
  }
}
