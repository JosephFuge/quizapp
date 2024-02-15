import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizapp/services/firestore.dart';
import 'package:quizapp/services/models.dart';

/// New version - Riverpod 2.0
final reportProvider = StreamNotifierProvider.autoDispose<ReportNotifier, Report>(ReportNotifier.new);

class ReportNotifier extends AutoDisposeStreamNotifier<Report> {
  @override
  Stream<Report> build() {
    return ref.watch(firestoreServiceProvider).streamReport();
  }

  void updateReport(Quiz quiz) {
    ref.watch(firestoreServiceProvider).updateUserReport(quiz);
  }
}
