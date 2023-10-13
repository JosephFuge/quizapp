import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/routes.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Report>(
      create: (context) => FirestoreService().streamReport(),
      initialData: Report(),
      child: MaterialApp(
        title: 'Flutter QuizApp',
        theme: appTheme,
        routes: QuizRoutes.appRoutes,
      ),
      catchError: (context, error) => Report(),
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
