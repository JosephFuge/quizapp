import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/providers/report_provider.dart';
import 'package:quizapp/services/models.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({required this.value, this.height = 12, super.key});
  final double value;
  final double height;

  _floor(double value, [min = 0.0]) {
    return value.sign <= min ? min : value;
  }

  _colorGen(double value) {
    int rbg = (value * 255).toInt();
    return Colors.deepOrange.withGreen(rbg).withRed(255 - rbg);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, box) {
      return Container(
          padding: const EdgeInsets.all(10),
          width: box.maxWidth,
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                height: height,
                width: box.maxWidth * _floor(value),
                decoration: BoxDecoration(
                  color: _colorGen(value),
                  borderRadius: BorderRadius.all(
                    Radius.circular(height),
                  ),
                ),
              ),
            ],
          ));
    });
  }
}

class TopicProgress extends ConsumerWidget {
  const TopicProgress({required this.topic, super.key});
  final Topic topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.watch(reportProvider);

    return report.when(
        data: (reportData) {
          return Row(
            children: [
              _progressCount(reportData, topic),
              Expanded(
                  child: ProgressBar(
                value: _calculateProgress(reportData, topic),
                height: 8,
              ))
            ],
          );
        },
        error: (_, __) => const SizedBox(),
        loading: () => const SizedBox());
  }

  Widget _progressCount(Report report, Topic topic) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        '${report.topics[topic.id]?.length ?? 0} / ${topic.quizzes.length}',
        style: const TextStyle(fontSize: 10, color: Colors.grey),
      ),
    );
  }

  double _calculateProgress(Report report, Topic topic) {
    try {
      return (report.topics[topic.id]?.length ?? 0) / topic.quizzes.length;
    } catch (err) {
      return 0.0;
    }
  }
}
