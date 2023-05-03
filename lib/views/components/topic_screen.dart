import 'package:flutter/material.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/views/pages/topics/drawer.dart';

class TopicScreen extends StatelessWidget {
  const TopicScreen({required this.topic, super.key});
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: topic.img,
          child: Image.asset('assets/${topic.img}',
              width: MediaQuery.of(context).size.width),
        ),
        Text(
          topic.title,
          style: const TextStyle(
              height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        QuizList(topic: topic),
      ]),
    );
  }
}
