import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/views/components/topic_item.dart';
import 'package:quizapp/views/pages/topics/drawer.dart';

class TopicsPage extends ConsumerWidget {
  const TopicsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Topic>>(
      future: ref.watch(firestoreServiceProvider).getTopics(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          final topics = snapshot.data!;

          return Scaffold(
            appBar: AppBar(title: const Text('Topics')),
            body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: topics.map((topic) => TopicItem(topic: topic)).toList(),
            ),
            drawer: TopicDrawer(topics: snapshot.data!),
          );
        } else {
          return const Center(
            child: Text('Topics data could not be found.'),
          );
        }
      },
    );
  }
}
