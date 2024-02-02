import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/routes.dart';
import 'package:quizapp/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter QuizApp',
        theme: appTheme,
        routes: QuizRoutes.appRoutes,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: FutureBuilder(
                future: null,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return const Text('Firebase initialized!');
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    print(snapshot.stackTrace);
                    return const Text('Could not initialize Firebase.');
                  } else {
                    return const Text('Initializing Firebase...');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
