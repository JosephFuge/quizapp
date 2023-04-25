import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/views/pages/login.dart';
import 'package:quizapp/views/pages/topics.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            stream: AuthService().userStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading...');
              } else if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return const TopicsPage();
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
