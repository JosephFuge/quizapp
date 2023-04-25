import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quizapp/services/auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LoginButton(
              text: 'Continue as Guest',
              icon: FontAwesomeIcons.user,
              loginMethod: AuthService().anonymousLogin)
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton(
      {required this.text,
      required this.icon,
      required this.loginMethod,
      super.key});

  final IconData icon;
  final String text;
  final Function loginMethod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: GestureDetector(
        onTap: () => loginMethod,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(width: 2.0, color: Colors.white),
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(icon, size: 16.0),
                const SizedBox(width: 8.0),
                Text(text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
