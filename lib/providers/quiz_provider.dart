import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';

/// New version - Riverpod 2.0
final quizProvider = AsyncNotifierProvider.family.autoDispose<QuizNotifier, Quiz, String>(QuizNotifier.new);

class QuizNotifier extends AutoDisposeFamilyAsyncNotifier<Quiz, String> {
  double progress = 0.0;
  Option? selected;
  final PageController controller = PageController();

  @override
  Future<Quiz> build(String arg) async {
    final quiz = ref.watch(firestoreServiceProvider).getQuiz(arg);
    return quiz;
  }

  void updateSelected(Option? option) {
    if (selected != option) {
      selected = option;
    }
  }

  void nextPage() async {
    await controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }
}

/// Old version - Provider Package
// Future<Quiz> fetchQuiz(FetchQuizRef ref, String quizId) async {
//   final FirebaseFirestore db = FirebaseFirestore.instance;
//
//   final ref = db.collection('quizzes').doc(quizId);
//   final snapshot = await ref.get();
//   return Quiz.fromJson(snapshot.data() ?? {});
// }

// class QuizStateNotifier extends _$QuizStateNotifier {
//   double _progress = 0.0;
//   Option? _selected;
//
//   final PageController _controller = PageController();
//
//   double get progress => _progress;
//   Option? get selected => _selected;
//   PageController get controller => _controller;
//
//   set progress(double value) {
//     _progress = value;
//     notifyListeners();
//   }
//
//   set selected(Option? option) {
//     if (_selected != option) {
//       _selected = option;
//       notifyListeners();
//     }
//   }
//
//   void nextPage() async {
//     await controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
//   }
// }
