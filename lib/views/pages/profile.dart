import 'package:flutter/material.dart';
import 'package:quizapp/services/auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: ElevatedButton(
            child: const Text('Sign Out'),
            onPressed: () async {
              await AuthService().signOut();
              if (context.mounted) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              }
            }),
      ),
    );
  }
}
