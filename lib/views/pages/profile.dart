import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth.dart';
import 'package:quizapp/views/components/bottom_nav_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(FontAwesomeIcons.circleUser,
                size: 100, color: Colors.white70),
            const SizedBox(height: 16),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  children: [
                    const TextSpan(
                      text: 'Name: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: AuthService().user!.displayName ?? '')
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                  children: [
                    const TextSpan(
                      text: 'Email: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(text: AuthService().user!.email ?? '')
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                child: const Text('Sign Out'),
                onPressed: () async {
                  await AuthService().signOut();
                  if (context.mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                })
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
