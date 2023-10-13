import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/views/components/bottom_nav_bar.dart';
import 'package:quizapp/views/pages/about.dart';
import 'package:quizapp/views/pages/login.dart';
import 'package:quizapp/views/pages/profile.dart';
import 'package:quizapp/views/pages/topics/topics.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: initialization,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            stream: AuthService().userStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return Scaffold(
                    appBar: currentPage == 0
                        ? null
                        : currentPage == 1
                            ? AppBar(title: const Text('About'))
                            : AppBar(title: const Text('Profile')),
                    body: AnimatedSwitcher(
                        // transitionBuilder: (child, animation) {
                        //   return SlideTransition(position: animation, child: child);
                        // },
                        duration: const Duration(seconds: 1),
                        child: currentPage == 0
                            ? const TopicsPage()
                            : currentPage == 1
                                ? const AboutPage()
                                : const ProfilePage()),
                    bottomNavigationBar: BottomNavBar(
                        currentPage: currentPage,
                        changePage: (newPage) {
                          if (currentPage != newPage) {
                            setState(() {
                              currentPage = newPage;
                            });
                          }
                        }));
              } else {
                return const LoginPage();
              }
            },
          );
        } else if (snapshot.hasError) {
          return const Text('Could not initialize Firebase.');
        } else {
          return const Text('Initializing Firebase...');
        }
      },
    );
  }
}
