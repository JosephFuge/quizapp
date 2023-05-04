import 'package:flutter/material.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/views/components/progress_bar.dart';
import 'package:quizapp/views/components/topic_screen.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({required this.topic, super.key});
  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: topic.img,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TopicScreen(topic: topic),
              ),
            );
          },
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: SizedBox(
                  child:
                      Image.asset('assets/${topic.img}', fit: BoxFit.contain),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              ),
              TopicProgress(topic: topic),
            ],
          ),
        ),
      ),
    );
  }
}
