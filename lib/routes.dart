import 'package:flutter/material.dart';
import 'package:quizapp/views/pages/about.dart';
import 'package:quizapp/views/pages/home.dart';
import 'package:quizapp/views/pages/login.dart';
import 'package:quizapp/views/pages/profile.dart';
import 'package:quizapp/views/pages/topics/topics.dart';

class QuizRoutes {
  static String loginPage = '/login';
  static String topicsPage = '/topics';
  static String profilePage = '/profile';
  static String aboutPage = '/about';

  static Map<String, Widget Function(BuildContext)> appRoutes = {
  '/': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/topics': (context) => const TopicsPage(),
  '/profile': (context) => const ProfilePage(),
  '/about': (context) => const AboutPage(),
};
}


