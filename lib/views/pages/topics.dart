import 'package:flutter/material.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/views/components/bottom_nav_bar.dart';
import 'package:quizapp/views/components/topic_item.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Topics')),
      bottomNavigationBar: const BottomNavBar(),
      body: FutureBuilder<List<Topic>>(
          future: FirestoreService().getTopics(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              final topics = snapshot.data!;

              return GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20.0),
                  crossAxisSpacing: 10.0,
                  crossAxisCount: 2,
                  children:
                      topics.map((topic) => TopicItem(topic: topic)).toList());
            } else {
              return const Center(
                child: Text('Topics data could not be found.'),
              );
            }
          }),
    );
  }
}
