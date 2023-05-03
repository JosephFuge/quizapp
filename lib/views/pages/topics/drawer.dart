import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:quizapp/services/models.dart';

class TopicDrawer extends StatelessWidget {
  const TopicDrawer({required this.topics, super.key});
  final List<Topic> topics;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView.separated(
      shrinkWrap: true,
      itemCount: topics.length,
      itemBuilder: (context, index) {
        final Topic topic = topics[index];
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0),
            child: Text(
              topic.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          QuizList(topic: topic),
        ]);
      },
      separatorBuilder: (context, num) => const Divider(),
    ));
  }
}

class QuizList extends StatelessWidget {
  const QuizList({required this.topic, super.key});
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: topic.quizzes.map((quiz) {
      return Card(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(quiz.title,
                  style: Theme.of(context).textTheme.headlineSmall),
              subtitle: Text(
                quiz.description,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              leading: QuizBadge(topic: topic, quizId: quiz.id),
            ),
          ),
        ),
      );
    }).toList());
  }
}

class QuizBadge extends StatelessWidget {
  const QuizBadge({required this.topic, required this.quizId, super.key});
  final Topic topic;
  final String quizId;

  @override
  Widget build(BuildContext context) {
    Report report = Provider.of<Report>(context);
    List completed = report.topics[topic.id] ?? [];

    if (completed.contains(quizId)) {
      return const Icon(FontAwesomeIcons.checkDouble, color: Colors.green);
    } else {
      return const Icon(FontAwesomeIcons.solidCircle, color: Colors.grey);
    }
  }
}
