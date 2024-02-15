import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/providers/quiz_provider.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';
import 'package:quizapp/views/components/progress_bar.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({required this.quizId, super.key});
  final String quizId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    final quiz = ref.watch(quizProvider(widget.quizId));
    final state = ref.watch(quizProvider(widget.quizId).notifier);

    return quiz.when(
        data: (data) {
          return Scaffold(
            appBar: AppBar(
              title: ProgressBar(value: progress),
              leading: IconButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (index) {
                  setState(() {
                    progress = index / (data.questions.length + 1);
                  });
                },
                itemCount: data.questions.length + 2,
                itemBuilder: (_, idx) {
                  if (idx == 0) {
                    return StartPage(quiz: data);
                  } else if (idx == data.questions.length + 1) {
                    return CongratsPage(quiz: data);
                  } else {
                    return QuestionPage(question: data.questions[idx - 1], quizId: widget.quizId);
                  }
                },
              ),
            ),
          );
        },
        error: (_, __) => const Scaffold(body: Text('Error!!! Quiz not found')),
        loading: () => const Scaffold(body: CircularProgressIndicator()));
  }
}

class StartPage extends ConsumerWidget {
  const StartPage({required this.quiz, super.key});
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizProvider(quiz.id).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Text(quiz.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 32),
        TextButton(
          onPressed: state.nextPage,
          child: const Text('Start Quiz!'),
        ),
      ],
    );
  }
}

class QuestionPage extends ConsumerWidget {
  const QuestionPage({required this.question, required this.quizId, super.key});
  final Question question;
  final String quizId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quizProvider(quizId).notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Text(question.text, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 32),
        for (Option option in question.options)
          InkWell(
            onTap: () {
              state.selected = option;
              _bottomSheet(context, option, state);
            },
            child: ListTile(
              leading: Icon(option == state.selected ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle, color: Colors.grey),
              title: Text(option.value),
            ),
          )
      ],
    );
  }

  _bottomSheet(BuildContext context, Option option, QuizNotifier state) {
    bool correct = option.correct;

    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.25,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(correct ? 'Good Job!' : 'Wrong'),
                Text(
                  option.detail,
                  style: const TextStyle(fontSize: 18, color: Colors.white54),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: correct ? Colors.green : Colors.red),
                  child: Text(
                    correct ? 'Onward!' : 'Try Again',
                    style: const TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    if (correct) {
                      state.nextPage();
                    }
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          );
        });
  }
}

class CongratsPage extends ConsumerWidget {
  const CongratsPage({required this.quiz, super.key});
  final Quiz quiz;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        Text('Congratulations! You finished the ${quiz.title} quiz!', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(
          height: 32,
        ),
        ElevatedButton.icon(
          icon: const Icon(FontAwesomeIcons.circleCheck, color: Colors.white),
          label: const Text(
            ' Mark Complete!',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            ref.watch(firestoreServiceProvider).updateUserReport(quiz);
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
